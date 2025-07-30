output "aws_kms_config_valid" {
  value = mongodbatlas_encryption_at_rest.this.aws_kms_config == null ? null : mongodbatlas_encryption_at_rest.this.aws_kms_config[*].valid
}

output "azure_key_vault_config_valid" {
  value = mongodbatlas_encryption_at_rest.this.azure_key_vault_config == null ? null : mongodbatlas_encryption_at_rest.this.azure_key_vault_config[*].valid
}

output "google_cloud_kms_config_valid" {
  value = mongodbatlas_encryption_at_rest.this.google_cloud_kms_config == null ? null : mongodbatlas_encryption_at_rest.this.google_cloud_kms_config[*].valid
}
