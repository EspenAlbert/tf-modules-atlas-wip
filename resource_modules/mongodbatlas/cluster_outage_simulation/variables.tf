variable "cluster_name" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "outage_filters" {
  type = list(object({
    cloud_provider = string
    region_name    = string
  }))
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    delete = optional(string)
  })
  nullable = true
  default  = null
}
