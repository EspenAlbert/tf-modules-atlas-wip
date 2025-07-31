variable "domain_restriction_enabled" {
  type = bool
}

variable "federation_settings_id" {
  type = string
}

variable "org_id" {
  type = string
}

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

variable "identity_provider_id" {
  type     = string
  nullable = true
  default  = null
}

variable "post_auth_role_grants" {
  type     = list(string)
  nullable = true
  default  = null
}
