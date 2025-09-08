variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "provider_settings" {
  type = object({
    backing_provider_name = string
    region_name           = string
  })
}

variable "delete_on_create_timeout" {
  type     = bool
  nullable = true
  default  = null
}

variable "tags" {
  type     = map(any)
  nullable = true
  default  = null
}

variable "termination_protection_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  nullable = true
  default  = null
}
