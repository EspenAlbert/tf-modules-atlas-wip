output "aws_kms_config_valid" {
  value     = mongodbatlas_encryption_at_rest.this.aws_kms_config == null ? null : mongodbatlas_encryption_at_rest.this.aws_kms_config[0].valid
  sensitive = true
}

output "private_endpoint_error_message" {
  value = var.enable_private_endpoint ? mongodbatlas_encryption_at_rest_private_endpoint.this[0].error_message : ""
}

output "private_endpoint_connection_name" {
  value = var.enable_private_endpoint ? mongodbatlas_encryption_at_rest_private_endpoint.this[0].private_endpoint_connection_name : ""
}

output "private_endpoint_status" {
  value = var.enable_private_endpoint ? mongodbatlas_encryption_at_rest_private_endpoint.this[0].status : ""
}
