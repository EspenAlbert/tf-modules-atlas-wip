module "atlas_project" {
  source           = "../../../../modules/02_project"
  name             = var.atlas_project_name
  org_id           = var.atlas_org_id
  auditing_enabled = true
  tags             = var.tags
}

module "atlas_aws" {
  source            = "../../../../modules/07_atlas_aws"
  project_id        = module.atlas_project.id
  aws_iam_role_name = var.aws_iam_role_name
  atlas_region      = var.atlas_region

  aws_iam_role_db_admin = {
    enabled  = true
    role_arn = aws_iam_role.app_role.arn
  }

  push_based_log_export = {
    enabled          = true
    create_s3_bucket = true
    bucket_name      = var.log_bucket_name
  }
  privatelink_with_managed_vpc_endpoint = {
    enabled                           = true
    vpc_id                            = module.vpc.vpc_id
    subnet_ids                        = module.vpc.private_subnets
    security_group_ids                = [aws_security_group.this.id]
    add_vpc_cidr_block_project_access = false
  }
  encryption_at_rest = {
    enabled                    = true
    enable_private_endpoint    = true
    enabled_for_search_nodes   = true
    require_private_networking = true
    aws_kms_key_id             = aws_kms_key.this.arn
  }
}

module "atlas_cluster" {
  source = "../../../../modules/08_cluster_poc"

  project_id = module.atlas_project.id
  name       = var.cluster_name
  auto_scaling = {
    compute_enabled            = true
    compute_max_instance_size  = "M60"
    compute_min_instance_size  = "M30"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
  regions = [{
    name          = var.atlas_region
    provider_name = "AWS"
    node_count    = 3
  }]
  encryption_at_rest_provider = "AWS"

  depends_on = [module.atlas_aws]
}
