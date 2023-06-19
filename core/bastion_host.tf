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

module "bastion" {
    source  = "Guimove/bastion/aws"
    version = "3.0.6"
    providers = {
        aws = aws.network_account
    }

    bucket_name = "mshafran-bastion-logs"
    region = "us-east-1"
    vpc_id = module.shared-base-network.vpc_id
    bastion_host_key_pair = local.mshafran_secret_key_name
    create_dns_record = "false"
    bastion_iam_policy_name = "bastionBucketAccess"
    create_elb = "false"
    auto_scaling_group_subnets = module.shared-base-network.public_subnets_ids
    tags = {
        "name" = "bastion_host"
    }
    }