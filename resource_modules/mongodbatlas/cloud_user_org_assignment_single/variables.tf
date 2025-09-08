variable "mongodbatlas_cloud_user_org_assignment" {
  type = object({
    org_id = string
    roles = object({
      org_roles = optional(list(string))
    })
    username = string
  })
}
