variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed for SSH inbound access. Must not be 0.0.0.0/0."
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "PAMonCloud-KP"
}

variable "s3_bucket_name" {
  description = "Name for the S3 bucket containing the BYOI zip"
  type        = string
}

variable "s3_file_name" {
  description = "BYOI zip file name to be downloaded from S3"
  type        = string
  default     = "PAM_Self-Hosted_on_AWS.zip"
}