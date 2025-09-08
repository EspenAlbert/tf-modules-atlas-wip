

resource "mongodbatlas_team_project_assignment" "this" {
  project_id = var.project_id
  role_names = var.role_names
  team_id    = var.team_id
}

