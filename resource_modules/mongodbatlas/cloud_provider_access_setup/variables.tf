variable "project_id" {
  type = string
}

variable "provider_name" {
  type = string
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
