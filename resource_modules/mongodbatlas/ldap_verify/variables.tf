variable "authz_query_template" {
  type     = string
  nullable = true
  default  = null
}

variable "bind_password" {
  type     = string
  nullable = true
  default  = null
}

variable "bind_username" {
  type     = string
  nullable = true
  default  = null
}

variable "ca_certificate" {
  type     = string
  nullable = true
  default  = null
}

variable "hostname" {
  type     = string
  nullable = true
  default  = null
}

variable "port" {
  type     = number
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}
