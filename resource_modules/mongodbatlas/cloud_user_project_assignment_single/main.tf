

resource "mongodbatlas_cloud_user_project_assignment" "this" {
  project_id = var.mongodbatlas_cloud_user_project_assignment.project_id
  roles      = var.mongodbatlas_cloud_user_project_assignment.roles
  username   = var.mongodbatlas_cloud_user_project_assignment.username
}

