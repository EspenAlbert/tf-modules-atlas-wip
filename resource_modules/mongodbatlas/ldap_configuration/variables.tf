variable "authentication_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "authorization_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "authz_query_template" {
  type     = string
  nullable = true
  default  = null
}

variable "bind_password" {
  type     = string
  nullable = true
  default  = null
}

variable "bind_username" {
  type     = string
  nullable = true
  default  = null
}

variable "ca_certificate" {
  type     = string
  nullable = true
  default  = null
}

variable "hostname" {
  type     = string
  nullable = true
  default  = null
}

variable "port" {
  type     = number
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "user_to_dn_mapping" {
  type = list(object({
    ldap_query   = optional(string)
    match        = optional(string)
    substitution = optional(string)
  }))
  nullable = true
  default  = null
}
