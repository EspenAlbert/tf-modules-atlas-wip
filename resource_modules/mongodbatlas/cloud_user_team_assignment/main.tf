

resource "mongodbatlas_cloud_user_team_assignment" "this" {
  org_id  = var.org_id
  team_id = var.team_id
  user_id = var.user_id
}

