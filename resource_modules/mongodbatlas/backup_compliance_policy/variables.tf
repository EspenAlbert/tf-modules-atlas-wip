variable "authorized_email" {
  type = string
}

variable "authorized_user_first_name" {
  type = string
}

variable "authorized_user_last_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "copy_protection_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "encryption_at_rest_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "on_demand_policy_item" {
  type = list(object({
    frequency_interval = number
    retention_value    = number
  }))
  nullable = true
  default  = null
}

variable "pit_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "policy_item_daily" {
  type = list(object({
    frequency_interval = number
    retention_unit     = string
    retention_value    = number
  }))
  nullable = true
  default  = null
}

variable "policy_item_hourly" {
  type = list(object({
    frequency_interval = number
    retention_unit     = string
    retention_value    = number
  }))
  nullable = true
  default  = null
}

variable "policy_item_monthly" {
  type = list(object({
    frequency_interval = number
    retention_unit     = string
    retention_value    = number
  }))
  nullable = true
  default  = null
}

variable "policy_item_weekly" {
  type = list(object({
    frequency_interval = number
    retention_unit     = string
    retention_value    = number
  }))
  nullable = true
  default  = null
}

variable "policy_item_yearly" {
  type = list(object({
    frequency_interval = number
    retention_value    = number
  }))
  nullable = true
  default  = null
}

variable "restore_window_days" {
  type     = number
  nullable = true
  default  = null
}
