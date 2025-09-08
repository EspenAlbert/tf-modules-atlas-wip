variable "mongodbatlas_cloud_user_project_assignment" {
  type = object({
    project_id = string
    roles      = list(string)
    username   = string
  })
}
