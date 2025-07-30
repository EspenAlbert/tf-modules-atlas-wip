output "cluster_id" {
  value = mongodbatlas_advanced_cluster.this.cluster_id
}

output "config_server_type" {
  value = mongodbatlas_advanced_cluster.this.config_server_type
}

output "create_date" {
  value = mongodbatlas_advanced_cluster.this.create_date
}

output "mongo_db_version" {
  value = mongodbatlas_advanced_cluster.this.mongo_db_version
}

output "state_name" {
  value = mongodbatlas_advanced_cluster.this.state_name
}
output "replication_specs_container_id" {
  value = mongodbatlas_advanced_cluster.this.replication_specs[*].container_id
}

output "replication_specs_external_id" {
  value = mongodbatlas_advanced_cluster.this.replication_specs[*].external_id
}

output "replication_specs_zone_id" {
  value = mongodbatlas_advanced_cluster.this.replication_specs[*].zone_id
}

output "connection_strings_private" {
  value = mongodbatlas_advanced_cluster.this.connection_strings == null ? null : mongodbatlas_advanced_cluster.this.connection_strings.private
}

output "connection_strings_private_endpoint" {
  value = mongodbatlas_advanced_cluster.this.connection_strings == null ? null : mongodbatlas_advanced_cluster.this.connection_strings.private_endpoint
}

output "connection_strings_private_srv" {
  value = mongodbatlas_advanced_cluster.this.connection_strings == null ? null : mongodbatlas_advanced_cluster.this.connection_strings.private_srv
}

output "connection_strings_standard" {
  value = mongodbatlas_advanced_cluster.this.connection_strings == null ? null : mongodbatlas_advanced_cluster.this.connection_strings.standard
}

output "connection_strings_standard_srv" {
  value = mongodbatlas_advanced_cluster.this.connection_strings == null ? null : mongodbatlas_advanced_cluster.this.connection_strings.standard_srv
}

output "pinned_fcv_version" {
  value = mongodbatlas_advanced_cluster.this.pinned_fcv == null ? null : mongodbatlas_advanced_cluster.this.pinned_fcv.version
}
