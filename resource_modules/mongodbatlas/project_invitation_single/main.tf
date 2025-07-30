

resource "mongodbatlas_project_invitation" "this" {
  project_id = var.mongodbatlas_project_invitation.project_id
  roles      = var.mongodbatlas_project_invitation.roles
  username   = var.mongodbatlas_project_invitation.username
}

