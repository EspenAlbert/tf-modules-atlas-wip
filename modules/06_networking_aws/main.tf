locals {
  aws_region               = replace(lower(var.atlas_region), "_", "-")
  use_aws_private_endpoint = var.aws_private_endpoint != null
}

resource "mongodbatlas_privatelink_endpoint" "mongodb_endpoint" {
  count = local.use_aws_private_endpoint ? 1 : 0

  project_id    = var.project_id
  provider_name = "AWS"
  region        = local.aws_region
}

resource "aws_vpc_endpoint" "aws_endpoint" {
  count = local.use_aws_private_endpoint ? 1 : 0

  vpc_id             = var.aws_private_endpoint.vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.mongodb_endpoint[0].endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.aws_private_endpoint.subnet_ids
  security_group_ids = var.aws_private_endpoint.security_group_ids
  tags               = var.tags
}

resource "mongodbatlas_privatelink_endpoint_service" "private_endpoint" {
  count = local.use_aws_private_endpoint ? 1 : 0

  project_id          = mongodbatlas_privatelink_endpoint.mongodb_endpoint[0].project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.mongodb_endpoint[0].private_link_id
  endpoint_service_id = aws_vpc_endpoint.aws_endpoint[0].id
  provider_name       = "AWS"
}

data "aws_vpc" "this" {
  count = local.use_aws_private_endpoint ? 1 : 0
  id    = var.aws_private_endpoint.vpc_id
}

resource "mongodbatlas_project_ip_access_list" "access_list_private_endpoints" {
  count = local.use_aws_private_endpoint && var.aws_private_endpoint.add_cidr_block_project_access ? 1 : 0

  project_id = var.project_id
  cidr_block = data.aws_vpc.this[0].cidr_block

  comment = substr("Access to Atlas from the Private Endpoint in ${local.aws_region} for vpc ${one(data.aws_vpc.this).id}", 0, 80) # MAX 80 chars

}
