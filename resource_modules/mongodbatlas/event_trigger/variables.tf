variable "app_id" {
  type     = string
  nullable = true
  default  = null
}

variable "config_collection" {
  type     = string
  nullable = true
  default  = null
}

variable "config_database" {
  type     = string
  nullable = true
  default  = null
}

variable "config_full_document" {
  type     = bool
  nullable = true
  default  = null
}

variable "config_full_document_before" {
  type     = bool
  nullable = true
  default  = null
}

variable "config_match" {
  type     = string
  nullable = true
  default  = null
}

variable "config_operation_type" {
  type     = string
  nullable = true
  default  = null
}

variable "config_operation_types" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "config_project" {
  type     = string
  nullable = true
  default  = null
}

variable "config_providers" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "config_schedule" {
  type     = string
  nullable = true
  default  = null
}

variable "config_service_id" {
  type     = string
  nullable = true
  default  = null
}

variable "disabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "function_id" {
  type     = string
  nullable = true
  default  = null
}

variable "name" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "type" {
  type     = string
  nullable = true
  default  = null
}

variable "unordered" {
  type     = bool
  nullable = true
  default  = null
}

variable "event_processors" {
  type = list(object({
    aws_eventbridge = optional(list(object({
      config_account_id = optional(string)
      config_region     = optional(string)
    })))
  }))
  nullable = true
  default  = null
}
