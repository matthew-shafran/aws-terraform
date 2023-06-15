locals {
  app_code = "testapp"
}

resource "aws_organizations_account" "testapp_account" {
  name  = "${local.app_code}-${var.environment_code}"
  email = "matthew.shafran+aws+${local.app_code}+${var.environment_code}@gmail.com"
  parent_id = var.ou_id
  role_name = "OrganizationAccountAccessRole"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.testapp_account.id}:role/OrganizationAccountAccessRole"
  }
  alias = "testapp_account"
}

resource "aws_default_vpc" "default" {
  force_destroy = true
  provider = aws.testapp_account
}