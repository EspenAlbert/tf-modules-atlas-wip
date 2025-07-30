variable "cluster_name" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "custom_zone_mappings" {
  type = set(object({
    location = optional(string)
    zone     = optional(string)
  }))
  nullable = true
  default  = null
}

variable "managed_namespaces" {
  type = set(object({
    collection                 = string
    custom_shard_key           = string
    db                         = string
    is_custom_shard_key_hashed = optional(bool)
    is_shard_key_unique        = optional(bool)
  }))
  nullable = true
  default  = null
}
