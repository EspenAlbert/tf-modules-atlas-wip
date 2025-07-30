

resource "mongodbatlas_ldap_verify" "this" {
  authz_query_template = var.mongodbatlas_ldap_verify.authz_query_template
  bind_password        = var.mongodbatlas_ldap_verify.bind_password
  bind_username        = var.mongodbatlas_ldap_verify.bind_username
  ca_certificate       = var.mongodbatlas_ldap_verify.ca_certificate
  hostname             = var.mongodbatlas_ldap_verify.hostname
  port                 = var.mongodbatlas_ldap_verify.port
  project_id           = var.mongodbatlas_ldap_verify.project_id
}

