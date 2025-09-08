variable "mongodbatlas_flex_cluster" {
  type = object({
    delete_on_create_timeout = optional(bool)
    name                     = string
    project_id               = string
    provider_settings = object({
      backing_provider_name = string
      region_name           = string
    })
    tags                           = optional(map(any))
    termination_protection_enabled = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
}
