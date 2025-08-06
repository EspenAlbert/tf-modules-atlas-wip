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
