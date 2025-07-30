variable "mongodbatlas_organization" {
  type = object({
    api_access_list_required     = optional(bool)
    description                  = string
    federation_settings_id       = optional(string)
    gen_ai_features_enabled      = optional(bool)
    multi_factor_auth_required   = optional(bool)
    name                         = string
    org_owner_id                 = string
    restrict_employee_access     = optional(bool)
    role_names                   = list(string)
    security_contact             = optional(string)
    skip_default_alerts_settings = optional(bool)
  })
}
