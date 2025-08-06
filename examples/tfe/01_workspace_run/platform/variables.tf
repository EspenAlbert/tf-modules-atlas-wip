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
