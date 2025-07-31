variable "cluster_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "delivery_type_config" {
  type = list(object({
    automated                 = optional(bool)
    download                  = optional(bool)
    oplog_inc                 = optional(number)
    oplog_ts                  = optional(number)
    point_in_time             = optional(bool)
    point_in_time_utc_seconds = optional(number)
    target_cluster_name       = optional(string)
    target_project_id         = optional(string)
  }))
  nullable = true
  default  = null
}

variable "snapshot_id" {
  type     = string
  nullable = true
  default  = null
}
