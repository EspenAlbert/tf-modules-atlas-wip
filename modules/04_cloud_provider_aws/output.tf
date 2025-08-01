output "aws_config" {
  value = mongodbatlas_cloud_provider_access_setup.this.aws_config
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



output "aws_kms_key_id" {
  value = local.kms_key_id
}

output "aws_iam_role_arn" {
  value = local.aws_iam_role_arn
}
