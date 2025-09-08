

resource "mongodbatlas_encryption_at_rest_private_endpoint" "this" {
  cloud_provider           = var.cloud_provider
  delete_on_create_timeout = var.delete_on_create_timeout
  project_id               = var.project_id
  region_name              = var.region_name
  timeouts                 = var.timeouts
}

