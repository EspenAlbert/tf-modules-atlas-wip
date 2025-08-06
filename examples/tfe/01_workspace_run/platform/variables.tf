variable "app_workspace" {
  type    = string
  default = ""
}
variable "tfe_org" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)."
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR notation, e.g. 10.0.0.0/16."
  }
}

variable "tfe_token" {
  type        = string
  description = "Terraform Enterprise token. Must have admin access to allow triggering a run in the sibling workspace"
  sensitive   = true
}
