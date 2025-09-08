

resource "mongodbatlas_backup_compliance_policy" "this" {
  authorized_email           = var.authorized_email
  authorized_user_first_name = var.authorized_user_first_name
  authorized_user_last_name  = var.authorized_user_last_name
  copy_protection_enabled    = var.copy_protection_enabled
  encryption_at_rest_enabled = var.encryption_at_rest_enabled
  dynamic "on_demand_policy_item" {
    for_each = var.on_demand_policy_item == null ? [] : var.on_demand_policy_item
    content {
      frequency_interval = on_demand_policy_item.value.frequency_interval
      retention_unit     = on_demand_policy_item.value.retention_unit
      retention_value    = on_demand_policy_item.value.retention_value
    }
  }
  pit_enabled = var.pit_enabled
  dynamic "policy_item_daily" {
    for_each = var.policy_item_daily == null ? [] : var.policy_item_daily
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }
  dynamic "policy_item_hourly" {
    for_each = var.policy_item_hourly == null ? [] : var.policy_item_hourly
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }
  dynamic "policy_item_monthly" {
    for_each = var.policy_item_monthly == null ? [] : var.policy_item_monthly
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }
  dynamic "policy_item_weekly" {
    for_each = var.policy_item_weekly == null ? [] : var.policy_item_weekly
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }
  dynamic "policy_item_yearly" {
    for_each = var.policy_item_yearly == null ? [] : var.policy_item_yearly
    content {
      frequency_interval = policy_item_yearly.value.frequency_interval
      retention_unit     = policy_item_yearly.value.retention_unit
      retention_value    = policy_item_yearly.value.retention_value
    }
  }
  project_id          = var.project_id
  restore_window_days = var.restore_window_days
}

