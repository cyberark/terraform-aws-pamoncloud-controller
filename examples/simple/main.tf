locals {
  aws_region    = "eu-west-1"
  instance_type = "m5.large"
  vpc_cidr      = "10.0.0.0/16"
  subnet_cidr   = "10.0.1.0/24"
}

provider "aws" {
  region = local.aws_region
}

################################################################################
# pamoncloud_controller Module
################################################################################
module "pamoncloud_controller" {
  source = "../../"

  s3_bucket_name   = var.s3_bucket_name
  s3_file_name     = var.s3_file_name
  key_name         = var.key_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
  instance_type    = local.instance_type
  vpc_cidr         = local.vpc_cidr
  subnet_cidr      = local.subnet_cidr
}