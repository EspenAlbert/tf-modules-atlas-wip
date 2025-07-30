

resource "mongodbatlas_mongodb_employee_access_grant" "this" {
  cluster_name    = var.cluster_name
  expiration_time = var.expiration_time
  grant_type      = var.grant_type
  project_id      = var.project_id
}

