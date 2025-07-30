variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "role_id" {
  type     = string
  nullable = true
  default  = null
}

variable "aws" {
  type = list(object({
    iam_assumed_role_arn = string
  }))
  nullable = true
  default  = null
}

variable "azure" {
  type = list(object({
    atlas_azure_app_id   = string
    service_principal_id = string
    tenant_id            = string
  }))
  nullable = true
  default  = null
}
