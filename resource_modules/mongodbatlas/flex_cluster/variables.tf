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
