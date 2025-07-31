variable "limit_name" {
  type = string
}

variable "overrun_policy" {
  type = string
}

variable "project_id" {
  type = string
}

variable "tenant_name" {
  type = string
}

variable "value" {
  type = number
}

variable "default_limit" {
  type     = number
  nullable = true
  default  = null
}

variable "maximum_limit" {
  type     = number
  nullable = true
  default  = null
}
