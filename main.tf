data "aws_partition" "current" {}

#### Create VPC and related objects

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "PAMonCloud-BYOI-Controller-VPC"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = false
}

resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#### Create IAM Policies & Roles

resource "aws_iam_role" "instance_role" {
  name = "PAMonCloud-BYOI-Controller-InstanceRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "instance_policy" {
  name        = "EC2RequiredPermissions"
  description = "Permissions for EC2 instance to perform required actions"

  policy = templatefile("${path.module}/files/policy.json.tpl", {
    s3_bucket_name = var.s3_bucket_name
    s3_file_name   = var.s3_file_name
    partition      = data.aws_partition.current.partition
  })
}

resource "aws_iam_role_policy_attachment" "instance_policy_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.instance_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "PAMonCloud-BYOI-Controller-InstanceProfile"
  role = aws_iam_role.instance_role.name
}

#### Create EC2 resources

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name

  metadata_options {
    http_tokens                 = "required"
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
  }

  user_data = templatefile("${path.module}/files/userdata.sh.tpl", {
    s3_bucket_name = var.s3_bucket_name
    s3_file_name   = var.s3_file_name
  })

  root_block_device {
    volume_size = 30
    encrypted   = true
    kms_key_id  = var.ebs_kms_key_id
  }

  tags = {
    Name = "PAMonCloud-BYOI-Controller"
  }
}
