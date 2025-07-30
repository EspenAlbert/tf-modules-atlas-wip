

resource "mongodbatlas_federated_settings_identity_provider" "this" {
  associated_domains           = var.mongodbatlas_federated_settings_identity_provider.associated_domains
  audience                     = var.mongodbatlas_federated_settings_identity_provider.audience
  authorization_type           = var.mongodbatlas_federated_settings_identity_provider.authorization_type
  client_id                    = var.mongodbatlas_federated_settings_identity_provider.client_id
  description                  = var.mongodbatlas_federated_settings_identity_provider.description
  federation_settings_id       = var.mongodbatlas_federated_settings_identity_provider.federation_settings_id
  groups_claim                 = var.mongodbatlas_federated_settings_identity_provider.groups_claim
  idp_type                     = var.mongodbatlas_federated_settings_identity_provider.idp_type
  issuer_uri                   = var.mongodbatlas_federated_settings_identity_provider.issuer_uri
  name                         = var.mongodbatlas_federated_settings_identity_provider.name
  protocol                     = var.mongodbatlas_federated_settings_identity_provider.protocol
  request_binding              = var.mongodbatlas_federated_settings_identity_provider.request_binding
  requested_scopes             = var.mongodbatlas_federated_settings_identity_provider.requested_scopes
  response_signature_algorithm = var.mongodbatlas_federated_settings_identity_provider.response_signature_algorithm
  sso_debug_enabled            = var.mongodbatlas_federated_settings_identity_provider.sso_debug_enabled
  sso_url                      = var.mongodbatlas_federated_settings_identity_provider.sso_url
  status                       = var.mongodbatlas_federated_settings_identity_provider.status
  user_claim                   = var.mongodbatlas_federated_settings_identity_provider.user_claim
}

