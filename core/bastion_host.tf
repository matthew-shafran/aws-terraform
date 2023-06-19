locals {
    mshafran_secret_key_name = "mshafran_bastion_host_key"
}

resource "aws_secretsmanager_secret" "mshafran_ssh_key" {
    provider = aws.network_account
    name = local.mshafran_secret_key_name
}

resource "aws_secretsmanager_secret_version" "mshafran_private_key" {
    provider = aws.network_account
    secret_id     = aws_secretsmanager_secret.mshafran_ssh_key.id
    secret_string = var.mshafran_private_ssh_key
}

