

resource "mongodbatlas_cloud_backup_snapshot_export_job" "this" {
  cluster_name = var.mongodbatlas_cloud_backup_snapshot_export_job.cluster_name
  dynamic "custom_data" {
    for_each = var.mongodbatlas_cloud_backup_snapshot_export_job.custom_data == null ? [] : var.mongodbatlas_cloud_backup_snapshot_export_job.custom_data
    content {
      key   = custom_data.value.key
      value = custom_data.value.value
    }
  }
  export_bucket_id = var.mongodbatlas_cloud_backup_snapshot_export_job.export_bucket_id
  project_id       = var.mongodbatlas_cloud_backup_snapshot_export_job.project_id
  snapshot_id      = var.mongodbatlas_cloud_backup_snapshot_export_job.snapshot_id
}

