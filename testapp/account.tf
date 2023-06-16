locals {
  app_code = "test-app"
}

resource "random_string" "this" {
  length = 4
  special = false
}

resource "aws_organizations_account" "test-app_account" {
  name  = "${local.app_code}-${var.environment_code}"
  email = "matthew.shafran+aws+${local.app_code}+${var.environment_code}+${random_string.this.result}@gmail.com"
  close_on_deletion = true
  parent_id = var.ou_id
  role_name = "OrganizationAccountAccessRole"
}

resource "time_sleep" "wait_project_init" {
  create_duration = "60s"
  depends_on = [ aws_organizations_account.test-app_account ]
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.test-app_account.id}:role/OrganizationAccountAccessRole"
  }
  alias = "test-app_account"
}

# Add code to delete default vpc
