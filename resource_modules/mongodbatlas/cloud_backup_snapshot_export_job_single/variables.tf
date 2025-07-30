variable "mongodbatlas_cloud_backup_snapshot_export_job" {
  type = object({
    cluster_name     = string
    export_bucket_id = string
    project_id       = string
    snapshot_id      = string
    custom_data = optional(set(object({
      key   = string
      value = string
    })))
  })
}
