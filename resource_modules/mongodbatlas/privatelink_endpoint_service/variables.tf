variable "endpoint_service_id" {
  type = string
}

variable "private_link_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "provider_name" {
  type = string
}

variable "endpoints" {
  type = list(object({
    endpoint_name = optional(string)
    ip_address    = optional(string)
  }))
  nullable = true
  default  = null
}

variable "gcp_project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "private_endpoint_ip_address" {
  type     = string
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
  })
  nullable = true
  default  = null
}
