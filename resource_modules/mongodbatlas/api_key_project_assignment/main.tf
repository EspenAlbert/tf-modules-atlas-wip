

resource "mongodbatlas_api_key_project_assignment" "this" {
  api_key_id = var.api_key_id
  project_id = var.project_id
  roles      = var.roles
}

