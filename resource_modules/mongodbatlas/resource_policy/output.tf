output "created_date" {
  value = mongodbatlas_resource_policy.this.created_date
}

output "last_updated_date" {
  value = mongodbatlas_resource_policy.this.last_updated_date
}

output "version" {
  value = mongodbatlas_resource_policy.this.version
}
output "created_by_user_name" {
  value = mongodbatlas_resource_policy.this.created_by_user == null ? null : mongodbatlas_resource_policy.this.created_by_user.name
}

output "last_updated_by_user_name" {
  value = mongodbatlas_resource_policy.this.last_updated_by_user == null ? null : mongodbatlas_resource_policy.this.last_updated_by_user.name
}
