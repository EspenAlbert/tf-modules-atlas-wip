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

resource "mongodbatlas_project_ip_access_list" "access_list_private_endpoints" {
  for_each           = local.use_aws_private_endpoint ? var.aws_private_endpoint.security_group_ids : toset([])
  project_id         = var.project_id
  aws_security_group = each.value

  comment = "Allow access to Atlas from AWS Security Group due to Private Endpoint in ${local.aws_region} for vpc_id ${var.aws_private_endpoint.vpc_id}"

}
