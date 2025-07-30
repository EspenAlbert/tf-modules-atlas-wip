output "certificates" {
  value = mongodbatlas_x509_authentication_database_user.this.certificates
}

output "current_certificate" {
  value = mongodbatlas_x509_authentication_database_user.this.current_certificate
}
