

resource "mongodbatlas_private_endpoint_regional_mode" "this" {
  enabled    = var.enabled
  project_id = var.project_id
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

