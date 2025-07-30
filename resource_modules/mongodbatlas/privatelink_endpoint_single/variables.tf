variable "mongodbatlas_privatelink_endpoint" {
  type = object({
    project_id    = string
    provider_name = string
    region        = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
  })
}
