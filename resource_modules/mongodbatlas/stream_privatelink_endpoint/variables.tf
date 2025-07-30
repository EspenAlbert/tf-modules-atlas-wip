variable "arn" {
  type     = string
  nullable = true
  default  = null
}

variable "dns_domain" {
  type     = string
  nullable = true
  default  = null
}

variable "dns_sub_domain" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_name" {
  type     = string
  nullable = true
  default  = null
}

variable "region" {
  type     = string
  nullable = true
  default  = null
}

variable "service_endpoint_id" {
  type     = string
  nullable = true
  default  = null
}

variable "vendor" {
  type     = string
  nullable = true
  default  = null
}
