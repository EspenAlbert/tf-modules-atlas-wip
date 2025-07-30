variable "data_process_region" {
  type = object({
    cloud_provider = string
    region         = string
  })
  nullable = true
  default  = null
}

variable "instance_name" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "stream_config" {
  type = object({
    tier = optional(string)
  })
  nullable = true
  default  = null
}
