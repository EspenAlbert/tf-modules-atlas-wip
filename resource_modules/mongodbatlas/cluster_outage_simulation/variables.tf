variable "cluster_name" {
  type = string
}

variable "outage_filters" {
  type = list(object({
    cloud_provider = string
    region_name    = string
  }))
}

variable "project_id" {
  type = string
}

variable "timeouts" {
  type = object({
    delete = optional(string)
  })
  nullable = true
  default  = null
}
