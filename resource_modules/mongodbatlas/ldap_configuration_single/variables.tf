variable "mongodbatlas_ldap_configuration" {
  type = object({
    authentication_enabled = bool
    authorization_enabled  = optional(bool)
    authz_query_template   = optional(string)
    bind_password          = string
    bind_username          = string
    ca_certificate         = optional(string)
    hostname               = string
    port                   = optional(number)
    project_id             = string
    user_to_dn_mapping = optional(list(object({
      ldap_query   = optional(string)
      match        = optional(string)
      substitution = optional(string)
    })))
  })
}
