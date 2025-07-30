variable "mongodbatlas_mongodb_employee_access_grant" {
  type = object({
    cluster_name    = string
    expiration_time = string
    grant_type      = string
    project_id      = string
  })
}
