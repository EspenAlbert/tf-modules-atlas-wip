

resource "mongodbatlas_network_container" "this" {
  atlas_cidr_block = var.atlas_cidr_block
  project_id       = var.project_id
  provider_name    = var.provider_name
  region           = var.region
  region_name      = var.region_name
  regions          = var.regions
}

