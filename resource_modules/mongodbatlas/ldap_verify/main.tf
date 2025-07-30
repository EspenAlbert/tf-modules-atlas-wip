

resource "mongodbatlas_ldap_verify" "this" {
  authz_query_template = var.authz_query_template
  bind_password        = var.bind_password
  bind_username        = var.bind_username
  ca_certificate       = var.ca_certificate
  hostname             = var.hostname
  port                 = var.port
  project_id           = var.project_id
}

