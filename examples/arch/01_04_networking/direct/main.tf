locals {
  tags = {
    "BU"       = "ConsumerProducts"
    "TeamName" = "TeamA"
    "AppName"  = "ProductManagementApp"
    "Env"      = var.environment
    "Version"  = "8.0"
    "Email"    = "marissa@acme.com"
  }
}

resource "mongodbatlas_privatelink_endpoint" "mongodb_endpoint" {
  project_id    = var.atlas_project_id
  provider_name = "AWS"
  region        = local.aws_region
}

resource "aws_vpc_endpoint" "aws_endpoint" {
  vpc_id             = module.vpc.vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.mongodb_endpoint.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [aws_security_group.this.id]
  tags               = local.tags
}

resource "mongodbatlas_privatelink_endpoint_service" "private_endpoint" {
  project_id          = mongodbatlas_privatelink_endpoint.mongodb_endpoint.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.mongodb_endpoint.private_link_id
  endpoint_service_id = aws_vpc_endpoint.aws_endpoint.id
  provider_name       = "AWS"
}
