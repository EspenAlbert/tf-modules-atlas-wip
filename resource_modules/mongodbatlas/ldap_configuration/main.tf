

resource "mongodbatlas_ldap_configuration" "this" {
  authentication_enabled = var.authentication_enabled
  authorization_enabled  = var.authorization_enabled
  authz_query_template   = var.authz_query_template
  bind_password          = var.bind_password
  bind_username          = var.bind_username
  ca_certificate         = var.ca_certificate
  hostname               = var.hostname
  port                   = var.port
  project_id             = var.project_id
  dynamic "user_to_dn_mapping" {
    for_each = var.user_to_dn_mapping == null ? [] : var.user_to_dn_mapping
    content {
      ldap_query   = user_to_dn_mapping.value.ldap_query
      match        = user_to_dn_mapping.value.match
      substitution = user_to_dn_mapping.value.substitution
    }
  }
}

