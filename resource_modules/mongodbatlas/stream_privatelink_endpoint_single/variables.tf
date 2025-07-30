variable "mongodbatlas_stream_privatelink_endpoint" {
  type = object({
    arn                 = optional(string)
    dns_domain          = optional(string)
    dns_sub_domain      = optional(list(string))
    project_id          = string
    provider_name       = string
    region              = optional(string)
    service_endpoint_id = optional(string)
    vendor              = string
  })
}
