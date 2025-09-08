

resource "mongodbatlas_network_peering" "this" {
  accepter_region_name     = var.mongodbatlas_network_peering.accepter_region_name
  atlas_cidr_block         = var.mongodbatlas_network_peering.atlas_cidr_block
  atlas_gcp_project_id     = var.mongodbatlas_network_peering.atlas_gcp_project_id
  atlas_vpc_name           = var.mongodbatlas_network_peering.atlas_vpc_name
  aws_account_id           = var.mongodbatlas_network_peering.aws_account_id
  azure_directory_id       = var.mongodbatlas_network_peering.azure_directory_id
  azure_subscription_id    = var.mongodbatlas_network_peering.azure_subscription_id
  container_id             = var.mongodbatlas_network_peering.container_id
  delete_on_create_timeout = var.mongodbatlas_network_peering.delete_on_create_timeout
  gcp_project_id           = var.mongodbatlas_network_peering.gcp_project_id
  network_name             = var.mongodbatlas_network_peering.network_name
  project_id               = var.mongodbatlas_network_peering.project_id
  provider_name            = var.mongodbatlas_network_peering.provider_name
  resource_group_name      = var.mongodbatlas_network_peering.resource_group_name
  route_table_cidr_block   = var.mongodbatlas_network_peering.route_table_cidr_block
  dynamic "timeouts" {
    for_each = var.mongodbatlas_network_peering.timeouts == null ? [] : [var.mongodbatlas_network_peering.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
  vnet_name = var.mongodbatlas_network_peering.vnet_name
  vpc_id    = var.mongodbatlas_network_peering.vpc_id
}

