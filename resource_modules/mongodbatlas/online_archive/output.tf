output "archive_id" {
  value = mongodbatlas_online_archive.this.archive_id
}

output "state" {
  value = mongodbatlas_online_archive.this.state
}
output "partition_fields_field_type" {
  value = mongodbatlas_online_archive.this.partition_fields == null ? null : mongodbatlas_online_archive.this.partition_fields[*].field_type
}
