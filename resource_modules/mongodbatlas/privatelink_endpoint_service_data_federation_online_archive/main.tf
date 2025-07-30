

resource "mongodbatlas_privatelink_endpoint_service_data_federation_online_archive" "this" {
  comment                    = var.comment
  customer_endpoint_dns_name = var.customer_endpoint_dns_name
  endpoint_id                = var.endpoint_id
  project_id                 = var.project_id
  provider_name              = var.provider_name
  region                     = var.region
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

