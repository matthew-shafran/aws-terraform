resource "aws_organizations_account" "network_account" {
  name  = "network_infra"
  email = "matthew.shafran+aws+network@gmail.com"
  parent_id = aws_organizations_organizational_unit.shared.id
  role_name = "OrganizationAccountAccessRole"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.network_account.id}:role/OrganizationAccountAccessRole"
  }
  alias = "network_account"
}

module "shared-base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  providers = {
    aws = aws.network_account
  }
  name_prefix    = "dev"
  single_nat     = true
  vpc_cidr_block = "10.50.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "10.50.0.0/28"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "10.50.128.0/19",
    "10.50.160.0/19"
  ]
}

module "dev-base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  providers = {
    aws = aws.network_account
  }
  name_prefix    = "dev"
  single_nat     = true
  vpc_cidr_block = "10.100.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "10.100.100.0/28"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "10.100.128.0/19",
    "10.100.160.0/19"
  ]
}

module "uat-base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  providers = {
    aws = aws.network_account
  }
  name_prefix    = "uat"
  single_nat     = true
  vpc_cidr_block = "10.150.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "10.150.0.0/28"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "10.150.128.0/19",
    "10.150.160.0/19"
  ]

}

module "prd-base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  providers = {
    aws = aws.network_account
  }
  name_prefix    = "prd"
  single_nat     = true
  vpc_cidr_block = "10.200.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "10.200.0.0/28"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "10.200.128.0/19",
    "10.200.160.0/19"
  ]

}