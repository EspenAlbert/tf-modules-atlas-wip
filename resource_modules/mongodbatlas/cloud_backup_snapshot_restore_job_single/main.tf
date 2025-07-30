

resource "mongodbatlas_cloud_backup_snapshot_restore_job" "this" {
  cluster_name = var.mongodbatlas_cloud_backup_snapshot_restore_job.cluster_name
  dynamic "delivery_type_config" {
    for_each = var.mongodbatlas_cloud_backup_snapshot_restore_job.delivery_type_config == null ? [] : var.mongodbatlas_cloud_backup_snapshot_restore_job.delivery_type_config
    content {
      automated                 = delivery_type_config.value.automated
      download                  = delivery_type_config.value.download
      oplog_inc                 = delivery_type_config.value.oplog_inc
      oplog_ts                  = delivery_type_config.value.oplog_ts
      point_in_time             = delivery_type_config.value.point_in_time
      point_in_time_utc_seconds = delivery_type_config.value.point_in_time_utc_seconds
      target_cluster_name       = delivery_type_config.value.target_cluster_name
      target_project_id         = delivery_type_config.value.target_project_id
    }
  }
  project_id  = var.mongodbatlas_cloud_backup_snapshot_restore_job.project_id
  snapshot_id = var.mongodbatlas_cloud_backup_snapshot_restore_job.snapshot_id
}

