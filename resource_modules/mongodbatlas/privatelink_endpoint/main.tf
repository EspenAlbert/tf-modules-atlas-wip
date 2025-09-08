

resource "mongodbatlas_privatelink_endpoint" "this" {
  delete_on_create_timeout = var.delete_on_create_timeout
  project_id               = var.project_id
  provider_name            = var.provider_name
  region                   = var.region
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

