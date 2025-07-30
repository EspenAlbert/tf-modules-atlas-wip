output "cluster_type" {
  value = mongodbatlas_flex_cluster.this.cluster_type
}

output "create_date" {
  value = mongodbatlas_flex_cluster.this.create_date
}

output "mongo_db_version" {
  value = mongodbatlas_flex_cluster.this.mongo_db_version
}

output "state_name" {
  value = mongodbatlas_flex_cluster.this.state_name
}

output "version_release_system" {
  value = mongodbatlas_flex_cluster.this.version_release_system
}
output "backup_settings_enabled" {
  value = mongodbatlas_flex_cluster.this.backup_settings == null ? null : mongodbatlas_flex_cluster.this.backup_settings.enabled
}

output "connection_strings_standard" {
  value = mongodbatlas_flex_cluster.this.connection_strings == null ? null : mongodbatlas_flex_cluster.this.connection_strings.standard
}

output "connection_strings_standard_srv" {
  value = mongodbatlas_flex_cluster.this.connection_strings == null ? null : mongodbatlas_flex_cluster.this.connection_strings.standard_srv
}

output "provider_settings_disk_size_gb" {
  value = mongodbatlas_flex_cluster.this.provider_settings.disk_size_gb
}

output "provider_settings_provider_name" {
  value = mongodbatlas_flex_cluster.this.provider_settings.provider_name
}
