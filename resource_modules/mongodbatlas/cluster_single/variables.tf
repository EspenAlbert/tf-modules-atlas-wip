variable "mongodbatlas_cluster" {
  type = object({
    accept_data_risks_and_force_replica_set_reconfig = optional(string)
    auto_scaling_compute_enabled                     = optional(bool)
    auto_scaling_compute_scale_down_enabled          = optional(bool)
    auto_scaling_disk_gb_enabled                     = optional(bool)
    backing_provider_name                            = optional(string)
    backup_enabled                                   = optional(bool)
    cloud_backup                                     = optional(bool)
    cluster_type                                     = optional(string)
    disk_size_gb                                     = optional(number)
    encryption_at_rest_provider                      = optional(string)
    mongo_db_major_version                           = optional(string)
    name                                             = string
    num_shards                                       = optional(number)
    paused                                           = optional(bool)
    pit_enabled                                      = optional(bool)
    project_id                                       = string
    provider_auto_scaling_compute_max_instance_size  = optional(string)
    provider_auto_scaling_compute_min_instance_size  = optional(string)
    provider_disk_iops                               = optional(number)
    provider_disk_type_name                          = optional(string)
    provider_instance_size_name                      = string
    provider_name                                    = string
    provider_region_name                             = optional(string)
    provider_volume_type                             = optional(string)
    redact_client_log_data                           = optional(bool)
    replication_factor                               = optional(number)
    retain_backups_enabled                           = optional(bool)
    termination_protection_enabled                   = optional(bool)
    version_release_system                           = optional(string)
    advanced_configuration = optional(list(object({
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
    })))
    bi_connector_config = optional(list(object({
      enabled         = optional(bool)
      read_preference = optional(string)
    })))
    labels = optional(set(object({
      key   = optional(string)
      value = optional(string)
    })))
    pinned_fcv = optional(list(object({
      expiration_date = string
    })))
    replication_specs = optional(set(object({
      num_shards = number
      zone_name  = optional(string)
      regions_config = optional(set(object({
        analytics_nodes = optional(number)
        electable_nodes = optional(number)
        priority        = optional(number)
        read_only_nodes = optional(number)
        region_name     = string
      })))
    })))
    tags = optional(set(object({
      key   = string
      value = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
}
