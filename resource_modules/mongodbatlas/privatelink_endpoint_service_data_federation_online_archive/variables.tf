variable "endpoint_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "provider_name" {
  type = string
}

variable "comment" {
  type     = string
  nullable = true
  default  = null
}

variable "customer_endpoint_dns_name" {
  type     = string
  nullable = true
  default  = null
}

variable "region" {
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
