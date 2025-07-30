

resource "mongodbatlas_cloud_backup_schedule" "this" {
  auto_export_enabled = var.mongodbatlas_cloud_backup_schedule.auto_export_enabled
  cluster_name        = var.mongodbatlas_cloud_backup_schedule.cluster_name
  dynamic "copy_settings" {
    for_each = var.mongodbatlas_cloud_backup_schedule.copy_settings == null ? [] : var.mongodbatlas_cloud_backup_schedule.copy_settings
    content {
      cloud_provider     = copy_settings.value.cloud_provider
      frequencies        = copy_settings.value.frequencies
      region_name        = copy_settings.value.region_name
      should_copy_oplogs = copy_settings.value.should_copy_oplogs
      zone_id            = copy_settings.value.zone_id
    }
  }
  dynamic "export" {
    for_each = var.mongodbatlas_cloud_backup_schedule.export == null ? [] : var.mongodbatlas_cloud_backup_schedule.export
    content {
      export_bucket_id = export.value.export_bucket_id
      frequency_type   = export.value.frequency_type
    }
  }
  dynamic "policy_item_daily" {
    for_each = var.mongodbatlas_cloud_backup_schedule.policy_item_daily == null ? [] : var.mongodbatlas_cloud_backup_schedule.policy_item_daily
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }
  dynamic "policy_item_hourly" {
    for_each = var.mongodbatlas_cloud_backup_schedule.policy_item_hourly == null ? [] : var.mongodbatlas_cloud_backup_schedule.policy_item_hourly
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }
  dynamic "policy_item_monthly" {
    for_each = var.mongodbatlas_cloud_backup_schedule.policy_item_monthly == null ? [] : var.mongodbatlas_cloud_backup_schedule.policy_item_monthly
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }
  dynamic "policy_item_weekly" {
    for_each = var.mongodbatlas_cloud_backup_schedule.policy_item_weekly == null ? [] : var.mongodbatlas_cloud_backup_schedule.policy_item_weekly
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }
  dynamic "policy_item_yearly" {
    for_each = var.mongodbatlas_cloud_backup_schedule.policy_item_yearly == null ? [] : var.mongodbatlas_cloud_backup_schedule.policy_item_yearly
    content {
      frequency_interval = policy_item_yearly.value.frequency_interval
      retention_unit     = policy_item_yearly.value.retention_unit
      retention_value    = policy_item_yearly.value.retention_value
    }
  }
  project_id                               = var.mongodbatlas_cloud_backup_schedule.project_id
  reference_hour_of_day                    = var.mongodbatlas_cloud_backup_schedule.reference_hour_of_day
  reference_minute_of_hour                 = var.mongodbatlas_cloud_backup_schedule.reference_minute_of_hour
  restore_window_days                      = var.mongodbatlas_cloud_backup_schedule.restore_window_days
  update_snapshots                         = var.mongodbatlas_cloud_backup_schedule.update_snapshots
  use_org_and_group_names_in_export_prefix = var.mongodbatlas_cloud_backup_schedule.use_org_and_group_names_in_export_prefix
}

