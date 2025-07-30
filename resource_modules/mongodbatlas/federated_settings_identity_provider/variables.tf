variable "associated_domains" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "audience" {
  type     = string
  nullable = true
  default  = null
}

variable "authorization_type" {
  type     = string
  nullable = true
  default  = null
}

variable "client_id" {
  type     = string
  nullable = true
  default  = null
}

variable "description" {
  type     = string
  nullable = true
  default  = null
}

variable "federation_settings_id" {
  type     = string
  nullable = true
  default  = null
}

variable "groups_claim" {
  type     = string
  nullable = true
  default  = null
}

variable "idp_type" {
  type     = string
  nullable = true
  default  = null
}

variable "issuer_uri" {
  type     = string
  nullable = true
  default  = null
}

variable "name" {
  type     = string
  nullable = true
  default  = null
}

variable "protocol" {
  type     = string
  nullable = true
  default  = null
}

variable "request_binding" {
  type     = string
  nullable = true
  default  = null
}

variable "requested_scopes" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "response_signature_algorithm" {
  type     = string
  nullable = true
  default  = null
}

variable "sso_debug_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "sso_url" {
  type     = string
  nullable = true
  default  = null
}

variable "status" {
  type     = string
  nullable = true
  default  = null
}

variable "user_claim" {
  type     = string
  nullable = true
  default  = null
}
