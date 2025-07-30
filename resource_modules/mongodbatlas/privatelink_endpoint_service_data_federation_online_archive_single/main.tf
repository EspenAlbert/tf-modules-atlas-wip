

resource "mongodbatlas_privatelink_endpoint_service_data_federation_online_archive" "this" {
  comment                    = var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.comment
  customer_endpoint_dns_name = var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.customer_endpoint_dns_name
  endpoint_id                = var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.endpoint_id
  project_id                 = var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.project_id
  provider_name              = var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.provider_name
  region                     = var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.region
  dynamic "timeouts" {
    for_each = var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.timeouts == null ? [] : [var.mongodbatlas_privatelink_endpoint_service_data_federation_online_archive.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

