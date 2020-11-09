terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = "~> 2.70"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
