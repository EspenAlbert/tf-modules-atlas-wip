variable "cluster_type" {
  type = string
}

variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "replication_specs" {
  type = list(object({
    region_configs = list(object({
      analytics_auto_scaling = optional(object({
        compute_enabled            = optional(bool)
        compute_max_instance_size  = optional(string)
        compute_min_instance_size  = optional(string)
        compute_scale_down_enabled = optional(bool)
        disk_gb_enabled            = optional(bool)
      }))
      analytics_specs = optional(object({
        disk_iops       = optional(number)
        disk_size_gb    = optional(number)
        ebs_volume_type = optional(string)
        instance_size   = optional(string)
        node_count      = optional(number)
      }))
      auto_scaling = optional(object({
        compute_enabled            = optional(bool)
        compute_max_instance_size  = optional(string)
        compute_min_instance_size  = optional(string)
        compute_scale_down_enabled = optional(bool)
        disk_gb_enabled            = optional(bool)
      }))
      backing_provider_name = optional(string)
      electable_specs = optional(object({
        disk_iops       = optional(number)
        disk_size_gb    = optional(number)
        ebs_volume_type = optional(string)
        instance_size   = optional(string)
        node_count      = optional(number)
      }))
      priority      = number
      provider_name = string
      read_only_specs = optional(object({
        disk_iops       = optional(number)
        disk_size_gb    = optional(number)
        ebs_volume_type = optional(string)
        instance_size   = optional(string)
        node_count      = optional(number)
      }))
      region_name = string
    }))
    zone_name = optional(string)
  }))
}

variable "accept_data_risks_and_force_replica_set_reconfig" {
  type     = string
  nullable = true
  default  = null
}

variable "advanced_configuration" {
  type = object({
    change_stream_options_pre_and_post_images_expire_after_seconds = optional(number)
    custom_openssl_cipher_config_tls12                             = optional(list(string))
    default_max_time_ms                                            = optional(number)
    default_write_concern                                          = optional(string, "majority")
    javascript_enabled                                             = optional(bool, false)
    minimum_enabled_tls_protocol                                   = optional(string, "TLS1_2")
    no_table_scan                                                  = optional(bool)
    oplog_min_retention_hours                                      = optional(number)
    oplog_size_mb                                                  = optional(number)
    sample_refresh_interval_bi_connector                           = optional(number)
    sample_size_bi_connector                                       = optional(number)
    tls_cipher_config_mode                                         = optional(string)
    transaction_lifetime_limit_seconds                             = optional(number)
  })
  nullable = true
  default = {
    default_write_concern        = "majority"
    javascript_enabled           = false
    minimum_enabled_tls_protocol = "TLS1_2"
  }
}

variable "backup_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "bi_connector_config" {
  type = object({
    enabled         = optional(bool)
    read_preference = optional(string)
  })
  nullable = true
  default  = null
}

variable "config_server_management_mode" {
  type     = string
  nullable = true
  default  = null
}

variable "delete_on_create_timeout" {
  type     = bool
  nullable = true
  default  = null
}

variable "encryption_at_rest_provider" {
  type     = string
  nullable = true
  default  = null
}

variable "global_cluster_self_managed_sharding" {
  type     = bool
  nullable = true
  default  = null
}

variable "labels" {
  type     = map(any)
  nullable = true
  default  = null
}

variable "mongo_db_major_version" {
  type     = string
  nullable = true
  default  = null
}

variable "paused" {
  type     = bool
  nullable = true
  default  = null
}

variable "pinned_fcv" {
  type = object({
    expiration_date = string
  })
  nullable = true
  default  = null
}

variable "pit_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "redact_client_log_data" {
  type     = bool
  nullable = true
  default  = null
}

variable "replica_set_scaling_strategy" {
  type     = string
  nullable = true
  default  = null
}

variable "retain_backups_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "root_cert_type" {
  type     = string
  nullable = true
  default  = null
}

variable "tags" {
  type     = map(any)
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
