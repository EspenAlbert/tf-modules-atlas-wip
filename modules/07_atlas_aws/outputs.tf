output "aws_config" {
  value     = mongodbatlas_cloud_provider_access_setup.this.aws_config
  sensitive = true
}

output "created_date" {
  value = mongodbatlas_cloud_provider_access_setup.this.created_date
}

output "last_updated_date" {
  value = mongodbatlas_cloud_provider_access_setup.this.last_updated_date
}

output "role_id" {
  value = mongodbatlas_cloud_provider_access_setup.this.role_id
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
