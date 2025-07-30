variable "mongodbatlas_privatelink_endpoint_service_data_federation_online_archive" {
  type = object({
    comment                    = optional(string)
    customer_endpoint_dns_name = optional(string)
    endpoint_id                = string
    project_id                 = string
    provider_name              = string
    region                     = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
  })
}
