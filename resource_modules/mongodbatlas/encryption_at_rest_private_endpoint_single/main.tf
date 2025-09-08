

resource "mongodbatlas_encryption_at_rest_private_endpoint" "this" {
  cloud_provider           = var.mongodbatlas_encryption_at_rest_private_endpoint.cloud_provider
  delete_on_create_timeout = var.mongodbatlas_encryption_at_rest_private_endpoint.delete_on_create_timeout
  project_id               = var.mongodbatlas_encryption_at_rest_private_endpoint.project_id
  region_name              = var.mongodbatlas_encryption_at_rest_private_endpoint.region_name
  timeouts                 = var.mongodbatlas_encryption_at_rest_private_endpoint.timeouts
}

