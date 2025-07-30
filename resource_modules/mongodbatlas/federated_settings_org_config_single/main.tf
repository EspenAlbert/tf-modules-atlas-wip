

resource "mongodbatlas_federated_settings_org_config" "this" {
  data_access_identity_provider_ids = var.mongodbatlas_federated_settings_org_config.data_access_identity_provider_ids
  domain_allow_list                 = var.mongodbatlas_federated_settings_org_config.domain_allow_list
  domain_restriction_enabled        = var.mongodbatlas_federated_settings_org_config.domain_restriction_enabled
  federation_settings_id            = var.mongodbatlas_federated_settings_org_config.federation_settings_id
  identity_provider_id              = var.mongodbatlas_federated_settings_org_config.identity_provider_id
  org_id                            = var.mongodbatlas_federated_settings_org_config.org_id
  post_auth_role_grants             = var.mongodbatlas_federated_settings_org_config.post_auth_role_grants
}

