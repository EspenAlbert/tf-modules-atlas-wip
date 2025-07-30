

resource "mongodbatlas_x509_authentication_database_user" "this" {
  customer_x509_cas       = var.customer_x509_cas
  months_until_expiration = var.months_until_expiration
  project_id              = var.project_id
  username                = var.username
}

