variable "mongodbatlas_cloud_backup_snapshot_export_bucket" {
  type = object({
    bucket_name    = string
    cloud_provider = string
    iam_role_id    = optional(string)
    project_id     = string
    role_id        = optional(string)
    service_url    = optional(string)
  })
}
