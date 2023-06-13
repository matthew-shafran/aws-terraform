resource "aws_organizations_account" "networking_account" {
  name  = "networking"
  email = "matthew.shafran+aws+networking@gmail.com"
  parent_id = aws_organizations_organizational_unit.shared.id
}

module "dev-base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  name_prefix    = "dev"
  single_nat     = false
  vpc_cidr_block = "10.100.0.0/16"
  parent_id      = aws_organizations_account.networking_account.id

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "10.100.0.0/19",
    "10.100.32.0/19"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "10.100.128.0/19",
    "10.100.160.0/19"
  ]
}

module "uat-base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  name_prefix    = "uat"
  single_nat     = false
  vpc_cidr_block = "10.150.0.0/16"
  parent_id      = aws_organizations_account.networking_account.id

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "10.150.0.0/19",
    "10.150.32.0/19"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "10.150.128.0/19",
    "10.150.160.0/19"
  ]

}

module "prd-base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"
  name_prefix    = "prd"
  single_nat     = false
  vpc_cidr_block = "10.200.0.0/16"
  parent_id      = aws_organizations_account.networking_account.id

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "10.200.0.0/19",
    "10.200.32.0/19"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "10.200.128.0/19",
    "10.200.160.0/19"
  ]

}