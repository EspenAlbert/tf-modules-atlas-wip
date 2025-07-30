variable "mongodbatlas_x509_authentication_database_user" {
  type = object({
    customer_x509_cas       = optional(string)
    months_until_expiration = optional(number)
    project_id              = string
    username                = optional(string)
  })
}
