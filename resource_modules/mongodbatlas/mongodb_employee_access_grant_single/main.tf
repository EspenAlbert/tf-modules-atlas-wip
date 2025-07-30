

resource "mongodbatlas_mongodb_employee_access_grant" "this" {
  cluster_name    = var.mongodbatlas_mongodb_employee_access_grant.cluster_name
  expiration_time = var.mongodbatlas_mongodb_employee_access_grant.expiration_time
  grant_type      = var.mongodbatlas_mongodb_employee_access_grant.grant_type
  project_id      = var.mongodbatlas_mongodb_employee_access_grant.project_id
}

