variable "mongodbatlas_private_endpoint_regional_mode" {
  type = object({
    enabled    = optional(bool)
    project_id = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
}
