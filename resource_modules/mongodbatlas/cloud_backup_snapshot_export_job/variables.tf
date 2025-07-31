variable "cluster_name" {
  type = string
}

variable "export_bucket_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "snapshot_id" {
  type = string
}

variable "custom_data" {
  type = set(object({
    key   = string
    value = string
  }))
  nullable = true
  default  = null
}
