variable "description" {
  type = string
}

variable "name" {
  type = string
}

variable "org_owner_id" {
  type = string
}

variable "role_names" {
  type = list(string)
}

variable "api_access_list_required" {
  type     = bool
  nullable = true
  default  = null
}

variable "federation_settings_id" {
  type     = string
  nullable = true
  default  = null
}

variable "gen_ai_features_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "multi_factor_auth_required" {
  type     = bool
  nullable = true
  default  = null
}

variable "restrict_employee_access" {
  type     = bool
  nullable = true
  default  = null
}

variable "security_contact" {
  type     = string
  nullable = true
  default  = null
}

variable "skip_default_alerts_settings" {
  type     = bool
  nullable = true
  default  = null
}
