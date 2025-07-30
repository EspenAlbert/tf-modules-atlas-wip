

resource "mongodbatlas_stream_privatelink_endpoint" "this" {
  arn                 = var.mongodbatlas_stream_privatelink_endpoint.arn
  dns_domain          = var.mongodbatlas_stream_privatelink_endpoint.dns_domain
  dns_sub_domain      = var.mongodbatlas_stream_privatelink_endpoint.dns_sub_domain
  project_id          = var.mongodbatlas_stream_privatelink_endpoint.project_id
  provider_name       = var.mongodbatlas_stream_privatelink_endpoint.provider_name
  region              = var.mongodbatlas_stream_privatelink_endpoint.region
  service_endpoint_id = var.mongodbatlas_stream_privatelink_endpoint.service_endpoint_id
  vendor              = var.mongodbatlas_stream_privatelink_endpoint.vendor
}

