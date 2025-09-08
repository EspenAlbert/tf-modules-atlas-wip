

resource "mongodbatlas_privatelink_endpoint" "this" {
  delete_on_create_timeout = var.mongodbatlas_privatelink_endpoint.delete_on_create_timeout
  project_id               = var.mongodbatlas_privatelink_endpoint.project_id
  provider_name            = var.mongodbatlas_privatelink_endpoint.provider_name
  region                   = var.mongodbatlas_privatelink_endpoint.region
  dynamic "timeouts" {
    for_each = var.mongodbatlas_privatelink_endpoint.timeouts == null ? [] : [var.mongodbatlas_privatelink_endpoint.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

