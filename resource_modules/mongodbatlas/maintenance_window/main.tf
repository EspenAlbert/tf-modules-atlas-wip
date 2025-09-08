

resource "mongodbatlas_maintenance_window" "this" {
  auto_defer              = var.auto_defer
  auto_defer_once_enabled = var.auto_defer_once_enabled
  day_of_week             = var.day_of_week
  defer                   = var.defer
  hour_of_day             = var.hour_of_day
  project_id              = var.project_id
  dynamic "protected_hours" {
    for_each = var.protected_hours == null ? [] : var.protected_hours
    content {
      end_hour_of_day   = protected_hours.value.end_hour_of_day
      start_hour_of_day = protected_hours.value.start_hour_of_day
    }
  }
}

