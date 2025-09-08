variable "mongodbatlas_cluster_outage_simulation" {
  type = object({
    cluster_name             = string
    delete_on_create_timeout = optional(bool)
    project_id               = string
    outage_filters = list(object({
      cloud_provider = string
      region_name    = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
  })
}
