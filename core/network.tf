resource "aws_organizations_account" "network_account" {
  name  = "my_new_account"
  email = "matthew.shafran+awsnetworking@gmail.com"
  parent_id = aws_organizations_organizational_unit.shared
}

