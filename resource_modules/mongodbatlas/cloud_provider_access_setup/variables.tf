variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_name" {
  type     = string
  nullable = true
  default  = null
}

variable "azure_config" {
  type = list(object({
    atlas_azure_app_id   = string
    service_principal_id = string
    tenant_id            = string
  }))
  nullable = true
  default  = null
}
