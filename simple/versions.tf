terraform {
  required_version = ">= 1.9.8, <= 1.13.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}