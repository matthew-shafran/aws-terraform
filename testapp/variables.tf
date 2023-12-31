variable "environment_code" {
    description = "Environment code for constructing resource names"
    type        = string

}

variable "ou_id" {
    description = "ID of the OU to create the account in"
    type        = string
}

variable "aws_standard_region" {
    description = "Standard region to build resources in"
    type        = string
}