variable "external_group_name" {
  type     = string
  nullable = true
  default  = null
}

variable "federation_settings_id" {
  type     = string
  nullable = true
  default  = null
}

variable "org_id" {
  type     = string
  nullable = true
  default  = null
}

variable "role_assignments" {
  type = set(object({
    group_id = optional(string)
    org_id   = optional(string)
    roles    = optional(list(string))
  }))
  nullable = true
  default  = null
}
