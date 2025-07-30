variable "mongodbatlas_federated_settings_identity_provider" {
  type = object({
    associated_domains           = optional(list(string))
    audience                     = optional(string)
    authorization_type           = optional(string)
    client_id                    = optional(string)
    description                  = optional(string)
    federation_settings_id       = string
    groups_claim                 = optional(string)
    idp_type                     = optional(string)
    issuer_uri                   = string
    name                         = string
    protocol                     = optional(string)
    request_binding              = optional(string)
    requested_scopes             = optional(list(string))
    response_signature_algorithm = optional(string)
    sso_debug_enabled            = optional(bool)
    sso_url                      = optional(string)
    status                       = optional(string)
    user_claim                   = optional(string)
  })
}
