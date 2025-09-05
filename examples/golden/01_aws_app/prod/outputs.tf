output "atlas_project" {
  value = module.atlas_project
}

output "atlas_aws_sensitive" {
  value = {
    access_setup_aws_config      = module.atlas_aws.access_setup_aws_config
    encryption_at_rest_sensitive = module.atlas_aws.encryption_at_rest_sensitive
  }
  sensitive = true
}

output "atlas_aws_non_sensitive" {
  value = {
    access_setup_created_date              = module.atlas_aws.access_setup_created_date
    access_setup_last_updated_date         = module.atlas_aws.access_setup_last_updated_date
    access_authorization_authorized_date   = module.atlas_aws.access_authorization_authorized_date
    access_authorization_feature_usages    = module.atlas_aws.access_authorization_feature_usages
    aws_iam_role_arn                       = module.atlas_aws.aws_iam_role_arn
    encryption_at_rest                     = module.atlas_aws.encryption_at_rest_non_sensitive
    privatelink_with_existing_vpc_endpoint = module.atlas_aws.privatelink_with_existing_vpc_endpoint
    privatelink_with_managed_vpc_endpoint  = module.atlas_aws.privatelink_with_managed_vpc_endpoint
    push_based_log_export                  = module.atlas_aws.push_based_log_export
    role_id                                = module.atlas_aws.role_id
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

output "aws_iam_role_app_arn" {
  value = aws_iam_role.lambda_exec.arn
}
