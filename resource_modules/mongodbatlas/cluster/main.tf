

resource "mongodbatlas_cluster" "this" {
  accept_data_risks_and_force_replica_set_reconfig = var.accept_data_risks_and_force_replica_set_reconfig
  dynamic "advanced_configuration" {
    for_each = var.advanced_configuration == null ? [] : var.advanced_configuration
    content {
      change_stream_options_pre_and_post_images_expire_after_seconds = advanced_configuration.value.change_stream_options_pre_and_post_images_expire_after_seconds
      custom_openssl_cipher_config_tls12                             = advanced_configuration.value.custom_openssl_cipher_config_tls12
      default_max_time_ms                                            = advanced_configuration.value.default_max_time_ms
      default_write_concern                                          = advanced_configuration.value.default_write_concern
      javascript_enabled                                             = advanced_configuration.value.javascript_enabled
      minimum_enabled_tls_protocol                                   = advanced_configuration.value.minimum_enabled_tls_protocol
      no_table_scan                                                  = advanced_configuration.value.no_table_scan
      oplog_min_retention_hours                                      = advanced_configuration.value.oplog_min_retention_hours
      oplog_size_mb                                                  = advanced_configuration.value.oplog_size_mb
      sample_refresh_interval_bi_connector                           = advanced_configuration.value.sample_refresh_interval_bi_connector
      sample_size_bi_connector                                       = advanced_configuration.value.sample_size_bi_connector
      tls_cipher_config_mode                                         = advanced_configuration.value.tls_cipher_config_mode
      transaction_lifetime_limit_seconds                             = advanced_configuration.value.transaction_lifetime_limit_seconds
    }
  }
  auto_scaling_compute_enabled            = var.auto_scaling_compute_enabled
  auto_scaling_compute_scale_down_enabled = var.auto_scaling_compute_scale_down_enabled
  auto_scaling_disk_gb_enabled            = var.auto_scaling_disk_gb_enabled
  backing_provider_name                   = var.backing_provider_name
  backup_enabled                          = var.backup_enabled
  dynamic "bi_connector_config" {
    for_each = var.bi_connector_config == null ? [] : var.bi_connector_config
    content {
      enabled         = bi_connector_config.value.enabled
      read_preference = bi_connector_config.value.read_preference
    }
  }
  cloud_backup                = var.cloud_backup
  cluster_type                = var.cluster_type
  disk_size_gb                = var.disk_size_gb
  encryption_at_rest_provider = var.encryption_at_rest_provider
  dynamic "labels" {
    for_each = var.labels == null ? [] : var.labels
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }
  mongo_db_major_version = var.mongo_db_major_version
  name                   = var.name
  num_shards             = var.num_shards
  paused                 = var.paused
  dynamic "pinned_fcv" {
    for_each = var.pinned_fcv == null ? [] : var.pinned_fcv
    content {
      expiration_date = pinned_fcv.value.expiration_date
    }
  }
  pit_enabled                                     = var.pit_enabled
  project_id                                      = var.project_id
  provider_auto_scaling_compute_max_instance_size = var.provider_auto_scaling_compute_max_instance_size
  provider_auto_scaling_compute_min_instance_size = var.provider_auto_scaling_compute_min_instance_size
  provider_disk_iops                              = var.provider_disk_iops
  provider_disk_type_name                         = var.provider_disk_type_name
  provider_instance_size_name                     = var.provider_instance_size_name
  provider_name                                   = var.provider_name
  provider_region_name                            = var.provider_region_name
  provider_volume_type                            = var.provider_volume_type
  redact_client_log_data                          = var.redact_client_log_data
  replication_factor                              = var.replication_factor
  dynamic "replication_specs" {
    for_each = var.replication_specs == null ? [] : var.replication_specs
    content {
      num_shards = replication_specs.value.num_shards
      zone_name  = replication_specs.value.zone_name
      dynamic "regions_config" {
        for_each = replication_specs.value.regions_config == null ? [] : replication_specs.value.regions_config
        content {
          analytics_nodes = regions_config.value.analytics_nodes
          electable_nodes = regions_config.value.electable_nodes
          priority        = regions_config.value.priority
          read_only_nodes = regions_config.value.read_only_nodes
          region_name     = regions_config.value.region_name
        }
      }
    }
  }
  retain_backups_enabled = var.retain_backups_enabled
  dynamic "tags" {
    for_each = var.tags == null ? [] : var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  termination_protection_enabled = var.termination_protection_enabled
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
  version_release_system = var.version_release_system
}

