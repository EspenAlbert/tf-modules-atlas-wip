

resource "mongodbatlas_cloud_user_team_assignment" "this" {
  org_id  = var.mongodbatlas_cloud_user_team_assignment.org_id
  team_id = var.mongodbatlas_cloud_user_team_assignment.team_id
  user_id = var.mongodbatlas_cloud_user_team_assignment.user_id
}

