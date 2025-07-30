variable "data_access_identity_provider_ids" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "domain_allow_list" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "domain_restriction_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "federation_settings_id" {
  type     = string
  nullable = true
  default  = null
}

variable "identity_provider_id" {
  type     = string
  nullable = true
  default  = null
}

variable "org_id" {
  type     = string
  nullable = true
  default  = null
}

variable "post_auth_role_grants" {
  type     = list(string)
  nullable = true
  default  = null
}
