variable "project_id" {
  type = string
}

variable "audit_authorization_success" {
  type     = bool
  nullable = true
  default  = null
}

variable "audit_filter" {
  type     = string
  nullable = true
  default  = null
}

variable "enabled" {
  type     = bool
  nullable = true
  default  = null
}
