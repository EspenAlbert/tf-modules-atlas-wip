variable "mongodbatlas_federated_settings_org_role_mapping" {
  type = object({
    external_group_name    = string
    federation_settings_id = string
    org_id                 = string
    role_assignments = set(object({
      group_id = optional(string)
      org_id   = optional(string)
      roles    = optional(list(string))
    }))
  })
}
