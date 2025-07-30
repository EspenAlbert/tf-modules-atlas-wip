variable "mongodbatlas_ldap_verify" {
  type = object({
    authz_query_template = optional(string)
    bind_password        = string
    bind_username        = string
    ca_certificate       = optional(string)
    hostname             = string
    port                 = number
    project_id           = string
  })
}
