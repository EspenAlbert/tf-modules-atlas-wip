

resource "mongodbatlas_privatelink_endpoint_service" "this" {
  delete_on_create_timeout = var.delete_on_create_timeout
  endpoint_service_id      = var.endpoint_service_id
  dynamic "endpoints" {
    for_each = var.endpoints == null ? [] : var.endpoints
    content {
      endpoint_name = endpoints.value.endpoint_name
      ip_address    = endpoints.value.ip_address
    }
  }
  gcp_project_id              = var.gcp_project_id
  private_endpoint_ip_address = var.private_endpoint_ip_address
  private_link_id             = var.private_link_id
  project_id                  = var.project_id
  provider_name               = var.provider_name
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

