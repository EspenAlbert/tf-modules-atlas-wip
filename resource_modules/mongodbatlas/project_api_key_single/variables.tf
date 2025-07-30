variable "mongodbatlas_project_api_key" {
  type = object({
    description = string
    project_assignment = set(object({
      project_id = string
      role_names = list(string)
    }))
  })
}
