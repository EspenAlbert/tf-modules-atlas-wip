output "aws_connection_status" {
  value = mongodbatlas_privatelink_endpoint_service.this.aws_connection_status
}

output "azure_status" {
  value = mongodbatlas_privatelink_endpoint_service.this.azure_status
}

output "delete_requested" {
  value = mongodbatlas_privatelink_endpoint_service.this.delete_requested
}

output "endpoint_group_name" {
  value = mongodbatlas_privatelink_endpoint_service.this.endpoint_group_name
}

output "error_message" {
  value = mongodbatlas_privatelink_endpoint_service.this.error_message
}

output "gcp_status" {
  value = mongodbatlas_privatelink_endpoint_service.this.gcp_status
}

output "interface_endpoint_id" {
  value = mongodbatlas_privatelink_endpoint_service.this.interface_endpoint_id
}

output "private_endpoint_connection_name" {
  value = mongodbatlas_privatelink_endpoint_service.this.private_endpoint_connection_name
}

output "private_endpoint_resource_id" {
  value = mongodbatlas_privatelink_endpoint_service.this.private_endpoint_resource_id
}
output "endpoints_status" {
  value = mongodbatlas_privatelink_endpoint_service.this.endpoints == null ? null : mongodbatlas_privatelink_endpoint_service.this.endpoints[*].status
}
