terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.2.0"
    }
    awsutils = {
      source = "cloudposse/awsutils"
      version = "0.16.0"
    }
  }
}



provider "awsutils" {
  region = var.aws_standard_region
}