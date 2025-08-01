
resource "mongodbatlas_encryption_at_rest" "this" {
  count = local.use_encryption_at_rest ? 1 : 0

  project_id               = var.project_id
  enabled_for_search_nodes = var.aws_encryption_at_rest.enabled_for_search_nodes

  aws_kms_config {
    role_id                    = mongodbatlas_cloud_provider_access_authorization.this.role_id
    customer_master_key_id     = local.kms_key_id
    enabled                    = local.use_encryption_at_rest
    region                     = var.atlas_region
    require_private_networking = var.aws_encryption_at_rest.require_private_networking
  }
}

resource "mongodbatlas_encryption_at_rest_private_endpoint" "this" {
  count = local.use_encryption_at_rest && var.aws_encryption_at_rest.require_private_networking ? 1 : 0

  project_id     = var.project_id
  cloud_provider = "AWS"
  region_name    = var.atlas_region
}
