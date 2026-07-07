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
  description = "CIDR blocks allowed for SSH inbound access. Must be a specific allow-list; do not use 0.0.0.0/0 in production."
  type        = list(string)
  default     = ["10.0.0.0/8"]
  validation {
    condition     = !contains(var.allowed_ssh_cidr, "0.0.0.0/0")
    error_message = "allowed_ssh_cidr must not include 0.0.0.0/0. Provide a specific CIDR allow-list."
  }
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

variable "ebs_kms_key_id" {
  description = "KMS key ID or ARN for root EBS encryption. Leave empty to use the default aws/ebs key."
  type        = string
  default     = ""
}