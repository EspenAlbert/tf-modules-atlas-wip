variable "data_process_region" {
  type = object({
    cloud_provider = string
    region         = string
  })
}

variable "instance_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "stream_config" {
  type = object({
    tier = optional(string)
  })
  nullable = true
  default  = null
}
