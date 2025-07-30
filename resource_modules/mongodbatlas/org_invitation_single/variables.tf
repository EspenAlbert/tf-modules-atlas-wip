variable "mongodbatlas_org_invitation" {
  type = object({
    org_id    = string
    roles     = list(string)
    teams_ids = optional(list(string))
    username  = string
  })
}
