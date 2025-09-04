output "atlas_project" {
  value = module.atlas_project
}

output "atlas_aws_sensitive" {
  value = {
    aws_config                   = module.atlas_aws.aws_config
    encryption_at_rest_sensitive = module.atlas_aws.encryption_at_rest_sensitive
  }
  sensitive = true
}

output "atlas_aws_non_sensitive" {
  value = {
    created_date                           = module.atlas_aws.created_date
    last_updated_date                      = module.atlas_aws.last_updated_date
    role_id                                = module.atlas_aws.role_id
    aws_iam_role_arn                       = module.atlas_aws.aws_iam_role_arn
    push_based_log_export                  = module.atlas_aws.push_based_log_export
    encryption_at_rest                     = module.atlas_aws.encryption_at_rest_non_sensitive
    privatelink_with_existing_vpc_endpoint = module.atlas_aws.privatelink_with_existing_vpc_endpoint
    privatelink_with_managed_vpc_endpoint  = module.atlas_aws.privatelink_with_managed_vpc_endpoint
  }
}

output "atlas_cluster" {
  value = module.atlas_cluster
}

output "vpc_output" {
  value = {
    vpc_id             = module.vpc.vpc_id
    private_subnet_ids = module.vpc.private_subnets
    region             = local.aws_region
  }
}
