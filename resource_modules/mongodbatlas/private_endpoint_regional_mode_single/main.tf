

resource "mongodbatlas_private_endpoint_regional_mode" "this" {
  enabled    = var.mongodbatlas_private_endpoint_regional_mode.enabled
  project_id = var.mongodbatlas_private_endpoint_regional_mode.project_id
  dynamic "timeouts" {
    for_each = var.mongodbatlas_private_endpoint_regional_mode.timeouts == null ? [] : [var.mongodbatlas_private_endpoint_regional_mode.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

