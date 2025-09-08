variable "mongodbatlas_cloud_user_team_assignment" {
  type = object({
    org_id  = string
    team_id = string
    user_id = string
  })
}
