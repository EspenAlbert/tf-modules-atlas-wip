output "azure_subscription_id" {
  value = mongodbatlas_network_container.this.azure_subscription_id
}

output "container_id" {
  value = mongodbatlas_network_container.this.container_id
}

output "gcp_project_id" {
  value = mongodbatlas_network_container.this.gcp_project_id
}

output "network_name" {
  value = mongodbatlas_network_container.this.network_name
}

output "provisioned" {
  value = mongodbatlas_network_container.this.provisioned
}

output "vnet_name" {
  value = mongodbatlas_network_container.this.vnet_name
}

output "vpc_id" {
  value = mongodbatlas_network_container.this.vpc_id
}
