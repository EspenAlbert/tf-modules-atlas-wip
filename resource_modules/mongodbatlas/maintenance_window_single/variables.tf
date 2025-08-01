variable "mongodbatlas_maintenance_window" {
  type = object({
    auto_defer              = optional(bool)
    auto_defer_once_enabled = optional(bool)
    day_of_week             = number
    defer                   = optional(bool)
    hour_of_day             = optional(number)
    project_id              = string
    start_asap              = optional(bool)
    protected_hours = optional(list(object({
      end_hour_of_day   = number
      start_hour_of_day = number
    })))
  })
}
