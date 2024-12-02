terraform {
  backend "s3" {
    bucket         = "ansible-terraform01"
    region         = "us-east-1"
    key            = "ansible-terraform01/terraform.tfstate"
    dynamodb_table = "ansible-terraform01-lock"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}