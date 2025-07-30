variable "mongodbatlas_federated_settings_org_config" {
  type = object({
    data_access_identity_provider_ids = optional(list(string))
    domain_allow_list                 = optional(list(string))
    domain_restriction_enabled        = bool
    federation_settings_id            = string
    identity_provider_id              = optional(string)
    org_id                            = string
    post_auth_role_grants             = optional(list(string))
  })
}
