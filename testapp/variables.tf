variable "autocloud_organization_id" {
    description = "AutoCloud Organization ID"
    type        = string
    sensitive   = true
}

variable "environment_code" {
    description = "Environment code for constructing resource names"
    type        = string

}

variable "ou_id" {
    description = "ID of the OU to create the account in"
    type        = string
}