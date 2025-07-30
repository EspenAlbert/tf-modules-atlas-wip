

resource "mongodbatlas_ldap_configuration" "this" {
  authentication_enabled = var.mongodbatlas_ldap_configuration.authentication_enabled
  authorization_enabled  = var.mongodbatlas_ldap_configuration.authorization_enabled
  authz_query_template   = var.mongodbatlas_ldap_configuration.authz_query_template
  bind_password          = var.mongodbatlas_ldap_configuration.bind_password
  bind_username          = var.mongodbatlas_ldap_configuration.bind_username
  ca_certificate         = var.mongodbatlas_ldap_configuration.ca_certificate
  hostname               = var.mongodbatlas_ldap_configuration.hostname
  port                   = var.mongodbatlas_ldap_configuration.port
  project_id             = var.mongodbatlas_ldap_configuration.project_id
  dynamic "user_to_dn_mapping" {
    for_each = var.mongodbatlas_ldap_configuration.user_to_dn_mapping == null ? [] : var.mongodbatlas_ldap_configuration.user_to_dn_mapping
    content {
      ldap_query   = user_to_dn_mapping.value.ldap_query
      match        = user_to_dn_mapping.value.match
      substitution = user_to_dn_mapping.value.substitution
    }
  }
}

