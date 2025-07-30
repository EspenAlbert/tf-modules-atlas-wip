variable "mongodbatlas_api_key" {
  type = object({
    description = string
    org_id      = string
    role_names  = list(string)
  })
}
