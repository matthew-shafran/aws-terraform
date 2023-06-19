module "bastion" {
    source  = "Guimove/bastion/aws"
    version = "3.0.6"
    providers = {
        aws = aws.network_account
    }

    bucket_name = "mshafran_bastion_logs"
    region = "us-east-1"
    vpc_id = module.shared-base-network.vpc_id
    bastion_host_key_pair = "bastion_host_key"
    create_dns_record = "false"
    bastion_iam_policy_name = "bastionBucketAccess"
    create_elb = "false"
    auto_scaling_group_subnets = module.shared-base-network.public_subnets_ids
    tags = {
        "name" = "bastion_host"
    }
    }