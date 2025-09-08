

resource "mongodbatlas_network_peering" "this" {
  accepter_region_name     = var.accepter_region_name
  atlas_cidr_block         = var.atlas_cidr_block
  atlas_gcp_project_id     = var.atlas_gcp_project_id
  atlas_vpc_name           = var.atlas_vpc_name
  aws_account_id           = var.aws_account_id
  azure_directory_id       = var.azure_directory_id
  azure_subscription_id    = var.azure_subscription_id
  container_id             = var.container_id
  delete_on_create_timeout = var.delete_on_create_timeout
  gcp_project_id           = var.gcp_project_id
  network_name             = var.network_name
  project_id               = var.project_id
  provider_name            = var.provider_name
  resource_group_name      = var.resource_group_name
  route_table_cidr_block   = var.route_table_cidr_block
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
  vnet_name = var.vnet_name
  vpc_id    = var.vpc_id
}

