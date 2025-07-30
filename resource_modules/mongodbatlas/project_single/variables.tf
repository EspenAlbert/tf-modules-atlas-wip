variable "mongodbatlas_project" {
  type = object({
    is_collect_database_specifics_statistics_enabled = optional(bool)
    is_data_explorer_enabled                         = optional(bool)
    is_extended_storage_sizes_enabled                = optional(bool)
    is_performance_advisor_enabled                   = optional(bool)
    is_realtime_performance_panel_enabled            = optional(bool)
    is_schema_advisor_enabled                        = optional(bool)
    name                                             = string
    org_id                                           = string
    project_owner_id                                 = optional(string)
    region_usage_restrictions                        = optional(string)
    tags                                             = optional(map(any))
    with_default_alerts_settings                     = optional(bool)
    limits = optional(set(object({
      name  = string
      value = number
    })))
    teams = optional(set(object({
      role_names = list(string)
      team_id    = string
    })))
  })
}
