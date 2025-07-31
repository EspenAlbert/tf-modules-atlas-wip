variable "bind_password" {
  type = string
}

variable "bind_username" {
  type = string
}

variable "hostname" {
  type = string
}

variable "port" {
  type = number
}

variable "project_id" {
  type = string
}

variable "authz_query_template" {
  type     = string
  nullable = true
  default  = null
}

variable "ca_certificate" {
  type     = string
  nullable = true
  default  = null
}
