variable "mongodbatlas_privatelink_endpoint" {
  type = object({
    delete_on_create_timeout = optional(bool)
    project_id               = string
    provider_name            = string
    region                   = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
  })
}
