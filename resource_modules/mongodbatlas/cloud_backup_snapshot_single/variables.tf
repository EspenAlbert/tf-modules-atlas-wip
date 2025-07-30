variable "mongodbatlas_cloud_backup_snapshot" {
  type = object({
    cluster_name      = string
    description       = string
    project_id        = string
    retention_in_days = number
    timeouts = optional(object({
      create = optional(string)
    }))
  })
}
