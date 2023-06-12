module "autocloud-access-role" {
  source  = "autoclouddev/autocloud-access-role/aws"
  version = "1.1.3"
  autocloud_organization_id = var.autocloud_organization_id
}