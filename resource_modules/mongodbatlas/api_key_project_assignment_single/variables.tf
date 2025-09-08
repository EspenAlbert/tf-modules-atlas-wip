variable "mongodbatlas_api_key_project_assignment" {
  type = object({
    api_key_id = string
    project_id = string
    roles      = list(string)
  })
}
