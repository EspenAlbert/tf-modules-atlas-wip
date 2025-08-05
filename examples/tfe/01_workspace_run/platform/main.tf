# MANAGED BY PLATFORM TEAM

data "tfe_outputs" "app" {
  count = var.app_workspace != "" ? 1 : 0

  organization = var.tfe_org
  workspace    = var.app_workspace
}

locals {
  atlas_endpoint_service_name = try(data.tfe_outputs.app[0].values.atlas_endpoint_service_name, "")
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

output "aws_vpc_endpoint_id" {
  value = try(aws_vpc_endpoint.aws_endpoint[0].id, "")
}
