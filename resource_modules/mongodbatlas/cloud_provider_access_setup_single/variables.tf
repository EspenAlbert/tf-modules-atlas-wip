variable "mongodbatlas_cloud_provider_access_setup" {
  type = object({
    project_id    = string
    provider_name = string
    azure_config = optional(list(object({
      atlas_azure_app_id   = string
      service_principal_id = string
      tenant_id            = string
    })))
  })
}
