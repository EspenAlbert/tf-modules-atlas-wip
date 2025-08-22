module "atlas_project" {
  source           = "../../../modules/02_project"
  name             = var.atlas_project_name
  org_id           = var.atlas_org_id
  auditing_enabled = true
  tags             = var.tags
}

module "atlas_aws" {
  source            = "../../../modules/07_atlas_aws"
  project_id        = module.atlas_project.id
  aws_iam_role_name = var.aws_iam_role_name

  push_based_log_export = {
    enabled     = true
    bucket_name = "my-s3-bucket"
  }
  atlas_region = var.atlas_region
  privatelink_with_managed_vpc_endpoint = {
    enabled            = true
    vpc_id             = module.vpc.vpc_id
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.this.id]
  }
}
