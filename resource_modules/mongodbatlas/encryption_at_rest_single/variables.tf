variable "mongodbatlas_encryption_at_rest" {
  type = object({
    enabled_for_search_nodes = optional(bool)
    project_id               = string
    aws_kms_config = optional(list(object({
      access_key_id              = optional(string)
      customer_master_key_id     = optional(string)
      enabled                    = optional(bool)
      region                     = optional(string)
      require_private_networking = optional(bool)
      role_id                    = optional(string)
      secret_access_key          = optional(string)
    })))
    azure_key_vault_config = optional(list(object({
      azure_environment          = optional(string)
      client_id                  = optional(string)
      enabled                    = optional(bool)
      key_identifier             = optional(string)
      key_vault_name             = optional(string)
      require_private_networking = optional(bool)
      resource_group_name        = optional(string)
      secret                     = optional(string)
      subscription_id            = optional(string)
      tenant_id                  = optional(string)
    })))
    google_cloud_kms_config = optional(list(object({
      enabled                 = optional(bool)
      key_version_resource_id = optional(string)
      service_account_key     = optional(string)
    })))
  })
}
