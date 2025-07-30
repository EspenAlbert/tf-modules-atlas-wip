

resource "mongodbatlas_cloud_backup_snapshot_export_job" "this" {
  cluster_name = var.cluster_name
  dynamic "custom_data" {
    for_each = var.custom_data == null ? [] : var.custom_data
    content {
      key   = custom_data.value.key
      value = custom_data.value.value
    }
  }
  export_bucket_id = var.export_bucket_id
  project_id       = var.project_id
  snapshot_id      = var.snapshot_id
}

