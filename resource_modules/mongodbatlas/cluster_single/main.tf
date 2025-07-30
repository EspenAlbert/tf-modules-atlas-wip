

resource "mongodbatlas_cluster" "this" {
  accept_data_risks_and_force_replica_set_reconfig = var.mongodbatlas_cluster.accept_data_risks_and_force_replica_set_reconfig
  dynamic "advanced_configuration" {
    for_each = var.mongodbatlas_cluster.advanced_configuration == null ? [] : var.mongodbatlas_cluster.advanced_configuration
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
  auto_scaling_compute_enabled            = var.mongodbatlas_cluster.auto_scaling_compute_enabled
  auto_scaling_compute_scale_down_enabled = var.mongodbatlas_cluster.auto_scaling_compute_scale_down_enabled
  auto_scaling_disk_gb_enabled            = var.mongodbatlas_cluster.auto_scaling_disk_gb_enabled
  backing_provider_name                   = var.mongodbatlas_cluster.backing_provider_name
  backup_enabled                          = var.mongodbatlas_cluster.backup_enabled
  dynamic "bi_connector_config" {
    for_each = var.mongodbatlas_cluster.bi_connector_config == null ? [] : var.mongodbatlas_cluster.bi_connector_config
    content {
      enabled         = bi_connector_config.value.enabled
      read_preference = bi_connector_config.value.read_preference
    }
  }
  cloud_backup                = var.mongodbatlas_cluster.cloud_backup
  cluster_type                = var.mongodbatlas_cluster.cluster_type
  disk_size_gb                = var.mongodbatlas_cluster.disk_size_gb
  encryption_at_rest_provider = var.mongodbatlas_cluster.encryption_at_rest_provider
  dynamic "labels" {
    for_each = var.mongodbatlas_cluster.labels == null ? [] : var.mongodbatlas_cluster.labels
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }
  mongo_db_major_version = var.mongodbatlas_cluster.mongo_db_major_version
  name                   = var.mongodbatlas_cluster.name
  num_shards             = var.mongodbatlas_cluster.num_shards
  paused                 = var.mongodbatlas_cluster.paused
  dynamic "pinned_fcv" {
    for_each = var.mongodbatlas_cluster.pinned_fcv == null ? [] : var.mongodbatlas_cluster.pinned_fcv
    content {
      expiration_date = pinned_fcv.value.expiration_date
    }
  }
  pit_enabled                                     = var.mongodbatlas_cluster.pit_enabled
  project_id                                      = var.mongodbatlas_cluster.project_id
  provider_auto_scaling_compute_max_instance_size = var.mongodbatlas_cluster.provider_auto_scaling_compute_max_instance_size
  provider_auto_scaling_compute_min_instance_size = var.mongodbatlas_cluster.provider_auto_scaling_compute_min_instance_size
  provider_disk_iops                              = var.mongodbatlas_cluster.provider_disk_iops
  provider_disk_type_name                         = var.mongodbatlas_cluster.provider_disk_type_name
  provider_instance_size_name                     = var.mongodbatlas_cluster.provider_instance_size_name
  provider_name                                   = var.mongodbatlas_cluster.provider_name
  provider_region_name                            = var.mongodbatlas_cluster.provider_region_name
  provider_volume_type                            = var.mongodbatlas_cluster.provider_volume_type
  redact_client_log_data                          = var.mongodbatlas_cluster.redact_client_log_data
  replication_factor                              = var.mongodbatlas_cluster.replication_factor
  dynamic "replication_specs" {
    for_each = var.mongodbatlas_cluster.replication_specs == null ? [] : var.mongodbatlas_cluster.replication_specs
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
  retain_backups_enabled = var.mongodbatlas_cluster.retain_backups_enabled
  dynamic "tags" {
    for_each = var.mongodbatlas_cluster.tags == null ? [] : var.mongodbatlas_cluster.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  termination_protection_enabled = var.mongodbatlas_cluster.termination_protection_enabled
  dynamic "timeouts" {
    for_each = var.mongodbatlas_cluster.timeouts == null ? [] : [var.mongodbatlas_cluster.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
  version_release_system = var.mongodbatlas_cluster.version_release_system
}

