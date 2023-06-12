resource "aws_organizations_account" "networking_account" {
  name  = "networking"
  email = "matthew.shafran+awsnetworking@gmail.com"
  parent_id = aws_organizations_organizational_unit.shared.id
}

