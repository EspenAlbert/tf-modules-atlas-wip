variable "name" {
  type        = string
  description = "Name of the workspace"
}

variable "organization" {
  type        = string
  description = "Terraform Enterprise organization"
}

variable "working_directory" {
  type        = string
  description = "Working directory for the workspace"
}

variable "vcs_repo" {
  type = object({
    branch         = string
    identifier     = string
    oauth_token_id = string
  })
  description = "VCS repository configuration"
}

variable "terraform_variables" {
  type        = map(string)
  description = "Terraform variables to set in the workspace"
  default     = {}
}

variable "env_vars" {
  type        = map(string)
  description = "Environment variables to set in the workspace"
  default     = {}
}

variable "sensitive_env_vars" {
  type        = map(string)
  description = "Sensitive environment variables to set in the workspace"
  sensitive   = true
  default     = {}
}


variable "project_id" {
  type        = string
  description = "project_id in TFE"
}
