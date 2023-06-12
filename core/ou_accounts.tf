data "aws_organizations_organization" "mshafran_org" {}

resource "aws_organizations_organizational_unit" "dev" {
  name      = "dev"
  parent_id = aws_organizations_organization.mshafran_org.roots[0].id
}

resource "aws_organizations_organizational_unit" "uat" {
  name      = "uat"
  parent_id = aws_organizations_organization.mshafran_org.roots[0].id
}

resource "aws_organizations_organizational_unit" "prd" {
  name      = "prd"
  parent_id = aws_organizations_organization.mshafran_org.roots[0].id
}

resource "aws_organizations_organizational_unit" "shared" {
  name      = "shared"
  parent_id = aws_organizations_organization.mshafran_org.roots[0].id
}