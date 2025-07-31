variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "provider_instance_size_name" {
  type = string
}

variable "provider_name" {
  type = string
}

variable "accept_data_risks_and_force_replica_set_reconfig" {
  type     = string
  nullable = true
  default  = null
}

variable "advanced_configuration" {
  type = list(object({
    change_stream_options_pre_and_post_images_expire_after_seconds = optional(number)
    custom_openssl_cipher_config_tls12                             = optional(list(string))
    default_max_time_ms                                            = optional(number)
    default_write_concern                                          = optional(string)
    javascript_enabled                                             = optional(bool)
    minimum_enabled_tls_protocol                                   = optional(string)
    no_table_scan                                                  = optional(bool)
    oplog_min_retention_hours                                      = optional(number)
    oplog_size_mb                                                  = optional(number)
    sample_refresh_interval_bi_connector                           = optional(number)
    sample_size_bi_connector                                       = optional(number)
    tls_cipher_config_mode                                         = optional(string)
    transaction_lifetime_limit_seconds                             = optional(number)
  }))
  nullable = true
  default  = null
}

variable "auto_scaling_compute_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "auto_scaling_compute_scale_down_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "auto_scaling_disk_gb_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "backing_provider_name" {
  type     = string
  nullable = true
  default  = null
}

variable "backup_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "bi_connector_config" {
  type = list(object({
    enabled         = optional(bool)
    read_preference = optional(string)
  }))
  nullable = true
  default  = null
}

variable "cloud_backup" {
  type     = bool
  nullable = true
  default  = null
}

variable "cluster_type" {
  type     = string
  nullable = true
  default  = null
}

variable "disk_size_gb" {
  type     = number
  nullable = true
  default  = null
}

variable "encryption_at_rest_provider" {
  type     = string
  nullable = true
  default  = null
}

variable "labels" {
  type = set(object({
    key   = optional(string)
    value = optional(string)
  }))
  nullable = true
  default  = null
}

variable "mongo_db_major_version" {
  type     = string
  nullable = true
  default  = null
}

variable "num_shards" {
  type     = number
  nullable = true
  default  = null
}

variable "paused" {
  type     = bool
  nullable = true
  default  = null
}

variable "pinned_fcv" {
  type = list(object({
    expiration_date = string
  }))
  nullable = true
  default  = null
}

variable "pit_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "provider_auto_scaling_compute_max_instance_size" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_auto_scaling_compute_min_instance_size" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_disk_iops" {
  type     = number
  nullable = true
  default  = null
}

variable "provider_disk_type_name" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_region_name" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_volume_type" {
  type     = string
  nullable = true
  default  = null
}

variable "redact_client_log_data" {
  type     = bool
  nullable = true
  default  = null
}

variable "replication_factor" {
  type     = number
  nullable = true
  default  = null
}

variable "replication_specs" {
  type = set(object({
    num_shards = number
    zone_name  = optional(string)
    regions_config = optional(set(object({
      analytics_nodes = optional(number)
      electable_nodes = optional(number)
      priority        = optional(number)
      read_only_nodes = optional(number)
      region_name     = string
    })))
  }))
  nullable = true
  default  = null
}

variable "retain_backups_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "tags" {
  type = set(object({
    key   = string
    value = string
  }))
  nullable = true
  default  = null
}

variable "termination_protection_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  nullable = true
  default  = null
}

variable "version_release_system" {
  type     = string
  nullable = true
  default  = null
}
