variable "aws_standard_region" {
    type        = string
    description = "Default region for resources"
}

variable "mshafran_private_ssh_key" {
    type        = string
    description = "Private SSH Key for user: mshafran"
    sensitive   = true
}