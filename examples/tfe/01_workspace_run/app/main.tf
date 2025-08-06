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


locals {
  vpc_endpoint_id      = try(data.tfe_outputs.platform[0].values.aws_vpc_endpoint_id, "")
  missing_vpc_endpoint = local.vpc_endpoint_id == ""
}

resource "mongodbatlas_privatelink_endpoint_service" "private_endpoint" { # Creation Order 3
  count = local.vpc_endpoint_id != "" ? 1 : 0

  project_id          = mongodbatlas_privatelink_endpoint.mongodb_endpoint.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.mongodb_endpoint.private_link_id
  endpoint_service_id = local.vpc_endpoint_id
  provider_name       = "AWS"
}

data "tfe_workspace" "platform" {
  count = local.missing_vpc_endpoint ? 1 : 0

  name         = var.platform_workspace
  organization = var.tfe_org
}

resource "tfe_workspace_run" "platform_run" {
  count = local.missing_vpc_endpoint ? 1 : 0

  workspace_id = data.tfe_workspace.platform[0].id

  apply {
    manual_confirm = true
    wait_for_run   = true # Wait for this private_endpoint service to be created before running the plaform
  }
  depends_on = [mongodbatlas_privatelink_endpoint_service.private_endpoint]
}
