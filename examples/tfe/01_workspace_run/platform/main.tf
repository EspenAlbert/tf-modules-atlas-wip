# MANAGED BY PLATFORM TEAM

data "tfe_outputs" "app" {
  count = var.app_workspace != "" ? 1 : 0

  organization = var.tfe_org
  workspace    = var.app_workspace
}

data "aws_vpc_endpoint" "existing" {


}
data "tfe_outputs" "platform" {
  workspace    = "vcs-platform"
  organization = var.tfe_org
}

locals {
  atlas_endpoint_service_name = try(data.tfe_outputs.app[0].values.atlas_endpoint_service_name, "")
  create_aws_vpc_endpoint     = local.atlas_endpoint_service_name != "" && var.app_workspace != ""
  vpc_endpoint_is_new         = try(data.tfe_outputs.platform.values.aws_vpc_endpoint_id, "") == ""
  trigger_app_run             = local.create_aws_vpc_endpoint && local.vpc_endpoint_is_new
}


resource "aws_vpc_endpoint" "aws_endpoint" { # Creation Order 2
  count = local.atlas_endpoint_service_name != "" ? 1 : 0

  # START internal module args
  vpc_id             = module.vpc.vpc_id
  vpc_endpoint_type  = "Interface"
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [aws_security_group.this.id]
  # END internal module args

  # Atlas depending field
  service_name = local.atlas_endpoint_service_name
}

data "tfe_workspace" "app" {
  count = local.trigger_app_run ? 1 : 0

  name         = var.app_workspace
  organization = var.tfe_org
}

resource "tfe_workspace_run" "app_run" {
  count = local.trigger_app_run ? 1 : 0

  workspace_id = data.tfe_workspace.app[0].id

  apply {
    manual_confirm = true
    wait_for_run   = false
  }
}
