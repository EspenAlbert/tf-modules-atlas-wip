variable "mongodbatlas_project_invitation" {
  type = object({
    project_id = string
    roles      = list(string)
    username   = string
  })
}
