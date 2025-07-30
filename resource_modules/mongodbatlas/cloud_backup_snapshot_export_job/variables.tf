variable "cluster_name" {
  type     = string
  nullable = true
  default  = null
}

variable "export_bucket_id" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "snapshot_id" {
  type     = string
  nullable = true
  default  = null
}

variable "custom_data" {
  type = set(object({
    key   = string
    value = string
  }))
  nullable = true
  default  = null
}
