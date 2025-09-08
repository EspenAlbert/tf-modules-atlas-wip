

resource "mongodbatlas_cloud_user_org_assignment" "this" {
  org_id   = var.org_id
  roles    = var.roles
  username = var.username
}

