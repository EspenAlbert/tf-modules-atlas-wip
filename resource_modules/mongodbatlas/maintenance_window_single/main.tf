

resource "mongodbatlas_maintenance_window" "this" {
  auto_defer              = var.mongodbatlas_maintenance_window.auto_defer
  auto_defer_once_enabled = var.mongodbatlas_maintenance_window.auto_defer_once_enabled
  day_of_week             = var.mongodbatlas_maintenance_window.day_of_week
  defer                   = var.mongodbatlas_maintenance_window.defer
  hour_of_day             = var.mongodbatlas_maintenance_window.hour_of_day
  project_id              = var.mongodbatlas_maintenance_window.project_id
  dynamic "protected_hours" {
    for_each = var.mongodbatlas_maintenance_window.protected_hours == null ? [] : var.mongodbatlas_maintenance_window.protected_hours
    content {
      end_hour_of_day   = protected_hours.value.end_hour_of_day
      start_hour_of_day = protected_hours.value.start_hour_of_day
    }
  }
}

