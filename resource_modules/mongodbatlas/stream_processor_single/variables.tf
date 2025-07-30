variable "mongodbatlas_stream_processor" {
  type = object({
    instance_name = string
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
  })
}
