variable "mongodbatlas_team" {
  type = object({
    name      = string
    org_id    = string
    usernames = list(string)
  })
}
