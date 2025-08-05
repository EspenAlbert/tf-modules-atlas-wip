variable "GH_TOKEN" {
  type        = string
  description = "GitHub token"
  sensitive   = true
}

variable "tfe_organization" {
  type        = string
  description = "Terraform Enterprise organization"
}
variable "tfe_workspace_names" {
  type = object({
    platform = optional(string, "vcs-platform")
    app      = optional(string, "vcs-app")
    project  = optional(string, "espen")
  })
}
variable "branch" {
  type        = string
  description = "Branch to use for the workspace"
  default     = "tfe-workspace-runs"
}

variable "vcs_repo" {
  type    = string
  default = "EspenAlbert/tf-modules-atlas-wip"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}


variable "platform_variables" {
  type = object({
    vpc_cidr = optional(string, "10.0.0.0/16")
    vpc_name = optional(string, "vpc-test")
  })
}

variable "app_variables" {
  type = object({
    atlas_project_id = string
  })
}

variable "atlas_credentials" {
  type      = map(string)
  sensitive = true
}

variable "aws_credentials" {
  type      = map(string)
  sensitive = true
}
