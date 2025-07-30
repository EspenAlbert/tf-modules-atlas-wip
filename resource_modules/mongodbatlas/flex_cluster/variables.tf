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

variable "provider_settings" {
  type = object({
    backing_provider_name = string
    region_name           = string
  })
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
