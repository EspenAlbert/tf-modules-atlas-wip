variable "external_group_name" {
  type = string
}

variable "federation_settings_id" {
  type = string
}

variable "org_id" {
  type = string
}

variable "role_assignments" {
  type = set(object({
    group_id = optional(string)
    org_id   = optional(string)
    roles    = optional(list(string))
  }))
}
