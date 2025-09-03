
locals {
  aws_region              = replace(lower(var.atlas_region), "_", "-")
  create_aws_vpc_endpoint = var.existing_vpc_endpoint_id == ""
  vpc_endpoint_id         = local.create_aws_vpc_endpoint ? aws_vpc_endpoint.aws_endpoint[0].id : data.aws_vpc_endpoint.this[0].id
  vpc_id                  = local.create_aws_vpc_endpoint ? aws_vpc_endpoint.aws_endpoint[0].vpc_id : data.aws_vpc_endpoint.this[0].vpc_id
  vpc_cidr_block          = data.aws_vpc.this.cidr_block
}

resource "mongodbatlas_privatelink_endpoint" "mongodb_endpoint" {
  project_id    = var.project_id
  provider_name = "AWS"
  region        = local.aws_region
}

resource "aws_vpc_endpoint" "aws_endpoint" {
  count = local.create_aws_vpc_endpoint ? 1 : 0
  lifecycle {
    precondition {
      condition     = length(var.aws_private_endpoint.subnet_ids) > 0 && length(var.aws_private_endpoint.security_group_ids) > 0
      error_message = "subnet_ids and security_group_ids must be provided when creating a new VPC endpoint"
    }
  }

  vpc_id             = var.aws_private_endpoint.vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.mongodb_endpoint.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.aws_private_endpoint.subnet_ids
  security_group_ids = var.aws_private_endpoint.security_group_ids
  tags               = var.aws_tags
}

data "aws_vpc_endpoint" "this" {
  count        = local.create_aws_vpc_endpoint ? 0 : 1
  id           = var.existing_vpc_endpoint_id
  service_name = mongodbatlas_privatelink_endpoint.mongodb_endpoint.endpoint_service_name // ensure the vpc endpoint use the same service name as the atlas private endpoint
}

resource "mongodbatlas_privatelink_endpoint_service" "private_endpoint" {
  project_id          = mongodbatlas_privatelink_endpoint.mongodb_endpoint.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.mongodb_endpoint.private_link_id
  endpoint_service_id = local.vpc_endpoint_id
  provider_name       = "AWS"
}

data "aws_vpc" "this" {
  id = local.vpc_id
}

resource "mongodbatlas_project_ip_access_list" "access_list_vpc_cidr_block" {
  count = var.add_vpc_cidr_block_project_access ? 1 : 0

  project_id = var.project_id
  cidr_block = local.vpc_cidr_block
  comment    = substr("Access to Atlas from the Private Endpoint in ${local.aws_region} for vpc ${local.vpc_id}", 0, 80) # MAX 80 chars

}
