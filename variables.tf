variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "m5.large"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed for SSH inbound access"
  type        = list(any)
  default     = ["0.0.0.0/0"] # Change for better security
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name for the S3 bucket containing the BYOI zip"
  type        = string
}

variable "s3_file_name" {
  description = "BYOI zip file name to be downloaded from S3"
  type        = string
}