terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.2.0"
    }
  }
}

provider "aws" {
  alias      = "second_account"

  assume_role {
    role_arn = "arn:aws:iam::973337368926:role/OrganizationAccountAccessRole"
  }
}