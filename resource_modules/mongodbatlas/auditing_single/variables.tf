variable "mongodbatlas_auditing" {
  type = object({
    audit_authorization_success = optional(bool)
    audit_filter                = optional(string)
    enabled                     = optional(bool)
    project_id                  = string
  })
}
