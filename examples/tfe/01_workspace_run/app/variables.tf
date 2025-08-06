variable "atlas_project_id" {
  type = string
}

variable "tfe_org" {
  type = string
}

variable "platform_workspace" {
  type = string
}

variable "aws_region" {
  type = string

  validation {
    condition     = can(regex("^([a-z]{2}-[a-z]+-\\d)$", var.aws_region))
    error_message = "aws_region must be a valid AWS region identifier, e.g. us-east-1."
  }
}
variable "tfe_token" {
  type        = string
  description = "Terraform Enterprise token. Must have admin access to allow triggering a run in the sibling workspace"
  sensitive   = true
}
