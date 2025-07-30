variable "mongodbatlas_cloud_backup_snapshot_restore_job" {
  type = object({
    cluster_name = string
    project_id   = string
    snapshot_id  = optional(string)
    delivery_type_config = optional(list(object({
      automated                 = optional(bool)
      download                  = optional(bool)
      oplog_inc                 = optional(number)
      oplog_ts                  = optional(number)
      point_in_time             = optional(bool)
      point_in_time_utc_seconds = optional(number)
      target_cluster_name       = optional(string)
      target_project_id         = optional(string)
    })))
  })
}
