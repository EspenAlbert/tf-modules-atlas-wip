variable "mongodbatlas_privatelink_endpoint_service" {
  type = object({
    delete_on_create_timeout    = optional(bool)
    endpoint_service_id         = string
    gcp_project_id              = optional(string)
    private_endpoint_ip_address = optional(string)
    private_link_id             = string
    project_id                  = string
    provider_name               = string
    endpoints = optional(list(object({
      endpoint_name = optional(string)
      ip_address    = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
  })
}
