

resource "mongodbatlas_cloud_backup_snapshot" "this" {
  cluster_name             = var.cluster_name
  delete_on_create_timeout = var.delete_on_create_timeout
  description              = var.description
  project_id               = var.project_id
  retention_in_days        = var.retention_in_days
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
    }
  }
}

