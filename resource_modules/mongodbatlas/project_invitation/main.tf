

resource "mongodbatlas_project_invitation" "this" {
  project_id = var.project_id
  roles      = var.roles
  username   = var.username
}

