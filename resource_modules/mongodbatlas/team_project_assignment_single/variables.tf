variable "mongodbatlas_team_project_assignment" {
  type = object({
    project_id = string
    role_names = list(string)
    team_id    = string
  })
}
