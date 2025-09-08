

resource "mongodbatlas_cloud_user_project_assignment" "this" {
  project_id = var.project_id
  roles      = var.roles
  username   = var.username
}

