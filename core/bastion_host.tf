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

data "aws_ami" "amazon-linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}

resource "aws_instance" "bastion" {
    provider = aws.network_account
    ami           = data.aws_ami.amazon-linux.id
    instance_type = "t2.micro"
    key_name      = aws_secretsmanager_secret.mshafran_ssh_key.name
    subnet_id     = module.shared-base-network.public_subnets_ids[0]

    tags = {
        Name = "bastion_host"
    }

    security_groups = ["${aws_security_group.allow_ssh_icmp.id}"]
}

resource "aws_security_group" "allow_ssh_icmp" {
    provider = aws.network_account
    name        = "allow_ssh_icmp"
    description = "Allow SSH and ALL ICMP IPV4 inbound traffic"
    vpc_id      = module.shared-base-network.vpc_id

    ingress {
        description = "SSH from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "ALL ICMP IPV4 from VPC"
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_ssh"
    }
}