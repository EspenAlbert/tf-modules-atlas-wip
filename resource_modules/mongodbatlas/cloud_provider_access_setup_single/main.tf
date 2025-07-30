

resource "mongodbatlas_cloud_provider_access_setup" "this" {
  dynamic "azure_config" {
    for_each = var.mongodbatlas_cloud_provider_access_setup.azure_config == null ? [] : var.mongodbatlas_cloud_provider_access_setup.azure_config
    content {
      atlas_azure_app_id   = azure_config.value.atlas_azure_app_id
      service_principal_id = azure_config.value.service_principal_id
      tenant_id            = azure_config.value.tenant_id
    }
  }
  project_id    = var.mongodbatlas_cloud_provider_access_setup.project_id
  provider_name = var.mongodbatlas_cloud_provider_access_setup.provider_name
}

