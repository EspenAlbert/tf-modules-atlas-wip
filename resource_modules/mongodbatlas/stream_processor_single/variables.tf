variable "mongodbatlas_stream_processor" {
  type = object({
    delete_on_create_timeout = optional(bool)
    instance_name            = string
    options = optional(object({
      dlq = object({
        coll            = string
        connection_name = string
        db              = string
      })
    }))
    pipeline       = string
    processor_name = string
    project_id     = string
    state          = optional(string)
    timeouts = optional(object({
      create = optional(string)
    }))
  })
}
