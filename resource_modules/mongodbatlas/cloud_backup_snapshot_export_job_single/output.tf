output "components" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.components
}

output "created_at" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.created_at
}

output "export_job_id" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.export_job_id
}

output "export_status_exported_collections" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.export_status_exported_collections
}

output "export_status_total_collections" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.export_status_total_collections
}

output "finished_at" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.finished_at
}

output "prefix" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.prefix
}

output "state" {
  value = mongodbatlas_cloud_backup_snapshot_export_job.this.state
}
