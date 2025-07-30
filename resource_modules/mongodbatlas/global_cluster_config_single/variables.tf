variable "mongodbatlas_global_cluster_config" {
  type = object({
    cluster_name = string
    project_id   = string
    custom_zone_mappings = optional(set(object({
      location = optional(string)
      zone     = optional(string)
    })))
    managed_namespaces = optional(set(object({
      collection                 = string
      custom_shard_key           = string
      db                         = string
      is_custom_shard_key_hashed = optional(bool)
      is_shard_key_unique        = optional(bool)
    })))
  })
}
