output "access_setup_aws_config" {
  value     = mongodbatlas_cloud_provider_access_setup.this.aws_config
  sensitive = true
}

output "access_setup_created_date" {
  value = mongodbatlas_cloud_provider_access_setup.this.created_date
}

output "access_setup_last_updated_date" {
  value = mongodbatlas_cloud_provider_access_setup.this.last_updated_date
}

output "role_id" {
  value = mongodbatlas_cloud_provider_access_authorization.this.role_id
}
output "access_authorization_authorized_date" {
  value = mongodbatlas_cloud_provider_access_authorization.this.authorized_date
}

output "access_authorization_feature_usages" {
  value = mongodbatlas_cloud_provider_access_authorization.this.feature_usages
}


output "aws_iam_role_arn" {
  value = local.aws_iam_role_arn
}

output "push_based_log_export" {
  value = try(module.push_based_log_export[0], null)
}

output "encryption_at_rest_sensitive" {
  value = try({
    aws_kms_config_valid = module.encryption_at_rest[0].aws_kms_config_valid
  }, null)
  sensitive = true
}

output "encryption_at_rest_non_sensitive" {
  value = try({
    private_endpoint_error_message   = module.encryption_at_rest[0].private_endpoint_error_message
    private_endpoint_connection_name = module.encryption_at_rest[0].private_endpoint_connection_name
    private_endpoint_status          = module.encryption_at_rest[0].private_endpoint_status
  }, null)

}

output "privatelink_with_existing_vpc_endpoint" {
  value = try(module.privatelink_with_existing_vpc_endpoint[0], null)
}

output "privatelink_with_managed_vpc_endpoint" {
  value = try(module.privatelink_with_managed_vpc_endpoint[0], null)
}
