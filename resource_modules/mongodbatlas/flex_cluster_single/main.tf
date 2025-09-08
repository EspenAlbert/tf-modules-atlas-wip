

resource "mongodbatlas_flex_cluster" "this" {
  delete_on_create_timeout       = var.mongodbatlas_flex_cluster.delete_on_create_timeout
  name                           = var.mongodbatlas_flex_cluster.name
  project_id                     = var.mongodbatlas_flex_cluster.project_id
  provider_settings              = var.mongodbatlas_flex_cluster.provider_settings
  tags                           = var.mongodbatlas_flex_cluster.tags
  termination_protection_enabled = var.mongodbatlas_flex_cluster.termination_protection_enabled
  timeouts                       = var.mongodbatlas_flex_cluster.timeouts
}

