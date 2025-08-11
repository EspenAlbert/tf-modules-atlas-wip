module "networking_aws" {
  source = "../../../modules/06_networking_aws"

  project_id   = module.atlas_project.id
  atlas_region = var.atlas_region
  aws_private_endpoint = {
    vpc_id             = module.vpc.vpc_id
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.this.id]
  }
  tags = local.tags
}
