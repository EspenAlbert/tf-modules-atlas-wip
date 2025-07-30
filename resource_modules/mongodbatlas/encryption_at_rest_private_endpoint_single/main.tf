

resource "mongodbatlas_encryption_at_rest_private_endpoint" "this" {
  cloud_provider = var.mongodbatlas_encryption_at_rest_private_endpoint.cloud_provider
  project_id     = var.mongodbatlas_encryption_at_rest_private_endpoint.project_id
  region_name    = var.mongodbatlas_encryption_at_rest_private_endpoint.region_name
}

