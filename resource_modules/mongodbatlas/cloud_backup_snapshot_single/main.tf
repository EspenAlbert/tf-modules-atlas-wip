

resource "mongodbatlas_cloud_backup_snapshot" "this" {
  cluster_name      = var.mongodbatlas_cloud_backup_snapshot.cluster_name
  description       = var.mongodbatlas_cloud_backup_snapshot.description
  project_id        = var.mongodbatlas_cloud_backup_snapshot.project_id
  retention_in_days = var.mongodbatlas_cloud_backup_snapshot.retention_in_days
  dynamic "timeouts" {
    for_each = var.mongodbatlas_cloud_backup_snapshot.timeouts == null ? [] : [var.mongodbatlas_cloud_backup_snapshot.timeouts]
    content {
      create = timeouts.value.create
    }
  }
}

