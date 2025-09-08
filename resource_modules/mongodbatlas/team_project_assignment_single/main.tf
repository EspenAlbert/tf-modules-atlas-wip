

resource "mongodbatlas_team_project_assignment" "this" {
  project_id = var.mongodbatlas_team_project_assignment.project_id
  role_names = var.mongodbatlas_team_project_assignment.role_names
  team_id    = var.mongodbatlas_team_project_assignment.team_id
}

