variable "cluster_name" {
  type = string
}

variable "coll_name" {
  type = string
}

variable "criteria" {
  type = list(object({
    date_field        = optional(string)
    date_format       = optional(string)
    expire_after_days = optional(number)
    query             = optional(string)
    type              = string
  }))
}

variable "db_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "collection_type" {
  type     = string
  nullable = true
  default  = null
}

variable "data_expiration_rule" {
  type = list(object({
    expire_after_days = number
  }))
  nullable = true
  default  = null
}

variable "data_process_region" {
  type = list(object({
    cloud_provider = optional(string)
    region         = optional(string)
  }))
  nullable = true
  default  = null
}

variable "delete_on_create_timeout" {
  type     = bool
  nullable = true
  default  = null
}

variable "partition_fields" {
  type = list(object({
    field_name = string
    order      = number
  }))
  nullable = true
  default  = null
}

variable "paused" {
  type     = bool
  nullable = true
  default  = null
}

variable "schedule" {
  type = list(object({
    day_of_month = optional(number)
    day_of_week  = optional(number)
    end_hour     = optional(number)
    end_minute   = optional(number)
    start_hour   = optional(number)
    start_minute = optional(number)
    type         = string
  }))
  nullable = true
  default  = null
}

variable "sync_creation" {
  type     = bool
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    create = optional(string)
  })
  nullable = true
  default  = null
}
