variable "mongodbatlas_backup_compliance_policy" {
  type = object({
    authorized_email           = string
    authorized_user_first_name = string
    authorized_user_last_name  = string
    copy_protection_enabled    = optional(bool)
    encryption_at_rest_enabled = optional(bool)
    pit_enabled                = optional(bool)
    project_id                 = string
    restore_window_days        = optional(number)
    on_demand_policy_item = optional(list(object({
      frequency_interval = number
      retention_value    = number
    })))
    policy_item_daily = optional(list(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    })))
    policy_item_hourly = optional(list(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    })))
    policy_item_monthly = optional(list(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    })))
    policy_item_weekly = optional(list(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    })))
    policy_item_yearly = optional(list(object({
      frequency_interval = number
      retention_value    = number
    })))
  })
}
