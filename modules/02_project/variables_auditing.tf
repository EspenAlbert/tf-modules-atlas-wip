variable "auditing" {
  type = object({
    audit_authorization_success = optional(bool)
    audit_filter                = optional(string)
    # enabled                     = optional(bool)
    # project_id                  = string
  })
}

variable "auditing_enabled" {
  type = bool
  default = false
}
