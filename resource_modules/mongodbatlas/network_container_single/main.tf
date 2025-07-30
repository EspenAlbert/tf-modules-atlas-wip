

resource "mongodbatlas_network_container" "this" {
  atlas_cidr_block = var.mongodbatlas_network_container.atlas_cidr_block
  project_id       = var.mongodbatlas_network_container.project_id
  provider_name    = var.mongodbatlas_network_container.provider_name
  region           = var.mongodbatlas_network_container.region
  region_name      = var.mongodbatlas_network_container.region_name
  regions          = var.mongodbatlas_network_container.regions
}

