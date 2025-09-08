variable "mongodbatlas_encryption_at_rest_private_endpoint" {
  type = object({
    cloud_provider           = string
    delete_on_create_timeout = optional(bool)
    project_id               = string
    region_name              = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
  })
}
