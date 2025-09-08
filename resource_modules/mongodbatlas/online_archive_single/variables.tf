variable "mongodbatlas_online_archive" {
  type = object({
    cluster_name             = string
    coll_name                = string
    collection_type          = optional(string)
    db_name                  = string
    delete_on_create_timeout = optional(bool)
    paused                   = optional(bool)
    project_id               = string
    sync_creation            = optional(bool)
    criteria = list(object({
      date_field        = optional(string)
      date_format       = optional(string)
      expire_after_days = optional(number)
      query             = optional(string)
      type              = string
    }))
    data_expiration_rule = optional(list(object({
      expire_after_days = number
    })))
    data_process_region = optional(list(object({
      cloud_provider = optional(string)
      region         = optional(string)
    })))
    partition_fields = optional(list(object({
      field_name = string
      order      = number
    })))
    schedule = optional(list(object({
      day_of_month = optional(number)
      day_of_week  = optional(number)
      end_hour     = optional(number)
      end_minute   = optional(number)
      start_hour   = optional(number)
      start_minute = optional(number)
      type         = string
    })))
    timeouts = optional(object({
      create = optional(string)
    }))
  })
}
