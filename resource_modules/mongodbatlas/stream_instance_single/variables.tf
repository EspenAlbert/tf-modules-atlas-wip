variable "mongodbatlas_stream_instance" {
  type = object({
    data_process_region = object({
      cloud_provider = string
      region         = string
    })
    instance_name = string
    project_id    = string
    stream_config = optional(object({
      tier = optional(string)
    }))
  })
}
