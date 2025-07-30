

resource "mongodbatlas_federated_settings_org_config" "this" {
  data_access_identity_provider_ids = var.data_access_identity_provider_ids
  domain_allow_list                 = var.domain_allow_list
  domain_restriction_enabled        = var.domain_restriction_enabled
  federation_settings_id            = var.federation_settings_id
  identity_provider_id              = var.identity_provider_id
  org_id                            = var.org_id
  post_auth_role_grants             = var.post_auth_role_grants
}

