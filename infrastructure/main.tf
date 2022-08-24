locals {
  prefix = "${terraform.workspace}-${var.prefix}"
  common_tags = {
    ManagedBy   = "Terraform"
    Department  = "systems",
    Provider    = "Company Name",
    Owner       = "DevOps Team"
    Billing     = "Infrastructure"
    Environment = terraform.workspace
    UserEmail   = "infra@gmail.com"
  }
}

terraform {
  required_version = ">= 1.2.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " 4.27.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-anderson"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}










