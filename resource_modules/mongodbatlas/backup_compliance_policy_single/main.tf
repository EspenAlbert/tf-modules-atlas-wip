

resource "mongodbatlas_backup_compliance_policy" "this" {
  authorized_email           = var.mongodbatlas_backup_compliance_policy.authorized_email
  authorized_user_first_name = var.mongodbatlas_backup_compliance_policy.authorized_user_first_name
  authorized_user_last_name  = var.mongodbatlas_backup_compliance_policy.authorized_user_last_name
  copy_protection_enabled    = var.mongodbatlas_backup_compliance_policy.copy_protection_enabled
  encryption_at_rest_enabled = var.mongodbatlas_backup_compliance_policy.encryption_at_rest_enabled
  dynamic "on_demand_policy_item" {
    for_each = var.mongodbatlas_backup_compliance_policy.on_demand_policy_item == null ? [] : var.mongodbatlas_backup_compliance_policy.on_demand_policy_item
    content {
      frequency_interval = on_demand_policy_item.value.frequency_interval
      retention_unit     = on_demand_policy_item.value.retention_unit
      retention_value    = on_demand_policy_item.value.retention_value
    }
  }
  pit_enabled = var.mongodbatlas_backup_compliance_policy.pit_enabled
  dynamic "policy_item_daily" {
    for_each = var.mongodbatlas_backup_compliance_policy.policy_item_daily == null ? [] : var.mongodbatlas_backup_compliance_policy.policy_item_daily
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }
  dynamic "policy_item_hourly" {
    for_each = var.mongodbatlas_backup_compliance_policy.policy_item_hourly == null ? [] : var.mongodbatlas_backup_compliance_policy.policy_item_hourly
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }
  dynamic "policy_item_monthly" {
    for_each = var.mongodbatlas_backup_compliance_policy.policy_item_monthly == null ? [] : var.mongodbatlas_backup_compliance_policy.policy_item_monthly
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }
  dynamic "policy_item_weekly" {
    for_each = var.mongodbatlas_backup_compliance_policy.policy_item_weekly == null ? [] : var.mongodbatlas_backup_compliance_policy.policy_item_weekly
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }
  dynamic "policy_item_yearly" {
    for_each = var.mongodbatlas_backup_compliance_policy.policy_item_yearly == null ? [] : var.mongodbatlas_backup_compliance_policy.policy_item_yearly
    content {
      frequency_interval = policy_item_yearly.value.frequency_interval
      retention_unit     = policy_item_yearly.value.retention_unit
      retention_value    = policy_item_yearly.value.retention_value
    }
  }
  project_id          = var.mongodbatlas_backup_compliance_policy.project_id
  restore_window_days = var.mongodbatlas_backup_compliance_policy.restore_window_days
}

