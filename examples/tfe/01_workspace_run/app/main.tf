# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/outputs
data "tfe_outputs" "platform" {
  count = var.platform_workspace != "" ? 1 : 0

  organization = var.tfe_org
  workspace    = var.platform_workspace
}

resource "mongodbatlas_privatelink_endpoint" "mongodb_endpoint" { # Creation Order 1
  project_id    = var.atlas_project_id
  provider_name = "AWS"
  region        = var.aws_region
}

output "atlas_endpoint_service_name" {
  value = mongodbatlas_privatelink_endpoint.mongodb_endpoint.endpoint_service_name
}

locals {
  vpc_endpoint_id = try(data.tfe_outputs.platform[0].values.aws_vpc_endpoint_id, "")
}

resource "mongodbatlas_privatelink_endpoint_service" "private_endpoint" { # Creation Order 3
  count = local.vpc_endpoint_id != "" ? 1 : 0

  project_id          = mongodbatlas_privatelink_endpoint.mongodb_endpoint.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.mongodb_endpoint.private_link_id
  endpoint_service_id = local.vpc_endpoint_id
  provider_name       = "AWS"
}
