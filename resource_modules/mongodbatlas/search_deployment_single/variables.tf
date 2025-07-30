variable "mongodbatlas_search_deployment" {
  type = object({
    cluster_name             = string
    delete_on_create_timeout = optional(bool)
    project_id               = string
    skip_wait_on_update      = optional(bool)
    specs = list(object({
      instance_size = string
      node_count    = number
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
}
