

resource "mongodbatlas_cloud_user_org_assignment" "this" {
  org_id   = var.mongodbatlas_cloud_user_org_assignment.org_id
  roles    = var.mongodbatlas_cloud_user_org_assignment.roles
  username = var.mongodbatlas_cloud_user_org_assignment.username
}

