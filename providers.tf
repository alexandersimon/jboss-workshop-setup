terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = "~> 2.70"
    tls = "~> 3.0"
  }
}

provider "aws" {
  region  = var.aws_region
}
