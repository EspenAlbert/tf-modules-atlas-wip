variable "mongodbatlas_event_trigger" {
  type = object({
    app_id                      = string
    config_collection           = optional(string)
    config_database             = optional(string)
    config_full_document        = optional(bool)
    config_full_document_before = optional(bool)
    config_match                = optional(string)
    config_operation_type       = optional(string)
    config_operation_types      = optional(list(string))
    config_project              = optional(string)
    config_providers            = optional(list(string))
    config_schedule             = optional(string)
    config_service_id           = optional(string)
    disabled                    = optional(bool)
    function_id                 = optional(string)
    name                        = string
    project_id                  = string
    type                        = string
    unordered                   = optional(bool)
    event_processors = optional(list(object({
      aws_eventbridge = optional(list(object({
        config_account_id = optional(string)
        config_region     = optional(string)
      })))
    })))
  })
}
