

resource "mongodbatlas_api_key_project_assignment" "this" {
  api_key_id = var.mongodbatlas_api_key_project_assignment.api_key_id
  project_id = var.mongodbatlas_api_key_project_assignment.project_id
  roles      = var.mongodbatlas_api_key_project_assignment.roles
}

