variable "enabled_for_search_nodes" {
  type     = bool
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "aws_kms_config" {
  type = list(object({
    access_key_id              = optional(string)
    customer_master_key_id     = optional(string)
    enabled                    = optional(bool)
    region                     = optional(string)
    require_private_networking = optional(bool)
    role_id                    = optional(string)
    secret_access_key          = optional(string)
  }))
  nullable = true
  default  = null
}

variable "azure_key_vault_config" {
  type = list(object({
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
  }))
  nullable = true
  default  = null
}

variable "google_cloud_kms_config" {
  type = list(object({
    enabled                 = optional(bool)
    key_version_resource_id = optional(string)
    service_account_key     = optional(string)
  }))
  nullable = true
  default  = null
}
