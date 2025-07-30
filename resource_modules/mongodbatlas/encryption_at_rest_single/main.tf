

resource "mongodbatlas_encryption_at_rest" "this" {
  dynamic "aws_kms_config" {
    for_each = var.mongodbatlas_encryption_at_rest.aws_kms_config == null ? [] : var.mongodbatlas_encryption_at_rest.aws_kms_config
    content {
      access_key_id              = aws_kms_config.value.access_key_id
      customer_master_key_id     = aws_kms_config.value.customer_master_key_id
      enabled                    = aws_kms_config.value.enabled
      region                     = aws_kms_config.value.region
      require_private_networking = aws_kms_config.value.require_private_networking
      role_id                    = aws_kms_config.value.role_id
      secret_access_key          = aws_kms_config.value.secret_access_key
    }
  }
  dynamic "azure_key_vault_config" {
    for_each = var.mongodbatlas_encryption_at_rest.azure_key_vault_config == null ? [] : var.mongodbatlas_encryption_at_rest.azure_key_vault_config
    content {
      azure_environment          = azure_key_vault_config.value.azure_environment
      client_id                  = azure_key_vault_config.value.client_id
      enabled                    = azure_key_vault_config.value.enabled
      key_identifier             = azure_key_vault_config.value.key_identifier
      key_vault_name             = azure_key_vault_config.value.key_vault_name
      require_private_networking = azure_key_vault_config.value.require_private_networking
      resource_group_name        = azure_key_vault_config.value.resource_group_name
      secret                     = azure_key_vault_config.value.secret
      subscription_id            = azure_key_vault_config.value.subscription_id
      tenant_id                  = azure_key_vault_config.value.tenant_id
    }
  }
  enabled_for_search_nodes = var.mongodbatlas_encryption_at_rest.enabled_for_search_nodes
  dynamic "google_cloud_kms_config" {
    for_each = var.mongodbatlas_encryption_at_rest.google_cloud_kms_config == null ? [] : var.mongodbatlas_encryption_at_rest.google_cloud_kms_config
    content {
      enabled                 = google_cloud_kms_config.value.enabled
      key_version_resource_id = google_cloud_kms_config.value.key_version_resource_id
      service_account_key     = google_cloud_kms_config.value.service_account_key
    }
  }
  project_id = var.mongodbatlas_encryption_at_rest.project_id
}

