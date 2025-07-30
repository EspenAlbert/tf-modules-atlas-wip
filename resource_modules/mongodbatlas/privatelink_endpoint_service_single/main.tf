

resource "mongodbatlas_privatelink_endpoint_service" "this" {
  endpoint_service_id = var.mongodbatlas_privatelink_endpoint_service.endpoint_service_id
  dynamic "endpoints" {
    for_each = var.mongodbatlas_privatelink_endpoint_service.endpoints == null ? [] : var.mongodbatlas_privatelink_endpoint_service.endpoints
    content {
      endpoint_name = endpoints.value.endpoint_name
      ip_address    = endpoints.value.ip_address
    }
  }
  gcp_project_id              = var.mongodbatlas_privatelink_endpoint_service.gcp_project_id
  private_endpoint_ip_address = var.mongodbatlas_privatelink_endpoint_service.private_endpoint_ip_address
  private_link_id             = var.mongodbatlas_privatelink_endpoint_service.private_link_id
  project_id                  = var.mongodbatlas_privatelink_endpoint_service.project_id
  provider_name               = var.mongodbatlas_privatelink_endpoint_service.provider_name
  dynamic "timeouts" {
    for_each = var.mongodbatlas_privatelink_endpoint_service.timeouts == null ? [] : [var.mongodbatlas_privatelink_endpoint_service.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

