variable "mongodbatlas_cluster_outage_simulation" {
  type = object({
    cluster_name = string
    project_id   = string
    outage_filters = list(object({
      cloud_provider = string
      region_name    = string
    }))
    timeouts = optional(object({
      delete = optional(string)
    }))
  })
}
