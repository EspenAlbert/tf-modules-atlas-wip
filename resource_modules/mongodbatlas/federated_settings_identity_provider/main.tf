

resource "mongodbatlas_federated_settings_identity_provider" "this" {
  associated_domains           = var.associated_domains
  audience                     = var.audience
  authorization_type           = var.authorization_type
  client_id                    = var.client_id
  description                  = var.description
  federation_settings_id       = var.federation_settings_id
  groups_claim                 = var.groups_claim
  idp_type                     = var.idp_type
  issuer_uri                   = var.issuer_uri
  name                         = var.name
  protocol                     = var.protocol
  request_binding              = var.request_binding
  requested_scopes             = var.requested_scopes
  response_signature_algorithm = var.response_signature_algorithm
  sso_debug_enabled            = var.sso_debug_enabled
  sso_url                      = var.sso_url
  status                       = var.status
  user_claim                   = var.user_claim
}

