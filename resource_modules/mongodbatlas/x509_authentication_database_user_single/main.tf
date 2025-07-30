

resource "mongodbatlas_x509_authentication_database_user" "this" {
  customer_x509_cas       = var.mongodbatlas_x509_authentication_database_user.customer_x509_cas
  months_until_expiration = var.mongodbatlas_x509_authentication_database_user.months_until_expiration
  project_id              = var.mongodbatlas_x509_authentication_database_user.project_id
  username                = var.mongodbatlas_x509_authentication_database_user.username
}

