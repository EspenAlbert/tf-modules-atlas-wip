

resource "mongodbatlas_stream_privatelink_endpoint" "this" {
  arn                 = var.arn
  dns_domain          = var.dns_domain
  dns_sub_domain      = var.dns_sub_domain
  project_id          = var.project_id
  provider_name       = var.provider_name
  region              = var.region
  service_endpoint_id = var.service_endpoint_id
  vendor              = var.vendor
}

