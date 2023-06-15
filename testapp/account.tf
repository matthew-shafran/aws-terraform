locals {
  app_code = "test-app"
}

resource "aws_organizations_account" "test-app_account" {
  name  = "${local.app_code}-${var.environment_code}"
  email = "matthew.shafran+aws+${local.app_code}+${var.environment_code}@gmail.com"
  close_on_deletion = true
  parent_id = var.ou_id
  role_name = "OrganizationAccountAccessRole"
}

resource "time_sleep" "wait_project_init" {
  create_duration = "60s"
  depends_on = [ aws_organizations_account.testapp_account ]
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.testapp_account.id}:role/OrganizationAccountAccessRole"
  }
  alias = "test-app_account"
}

# Add code to delete default vpc