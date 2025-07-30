output "cluster_id" {
  value = mongodbatlas_cluster.this.cluster_id
}

output "connection_strings" {
  value = mongodbatlas_cluster.this.connection_strings
}

output "container_id" {
  value = mongodbatlas_cluster.this.container_id
}

output "mongo_db_version" {
  value = mongodbatlas_cluster.this.mongo_db_version
}

output "mongo_uri" {
  value = mongodbatlas_cluster.this.mongo_uri
}

output "mongo_uri_updated" {
  value = mongodbatlas_cluster.this.mongo_uri_updated
}

output "mongo_uri_with_options" {
  value = mongodbatlas_cluster.this.mongo_uri_with_options
}

output "provider_encrypt_ebs_volume_flag" {
  value = mongodbatlas_cluster.this.provider_encrypt_ebs_volume_flag
}

output "snapshot_backup_policy" {
  value = mongodbatlas_cluster.this.snapshot_backup_policy
}

output "srv_address" {
  value = mongodbatlas_cluster.this.srv_address
}

output "state_name" {
  value = mongodbatlas_cluster.this.state_name
}
output "pinned_fcv_version" {
  value = mongodbatlas_cluster.this.pinned_fcv == null ? null : mongodbatlas_cluster.this.pinned_fcv[*].version
}
