variable "mongodbatlas_alert_configuration" {
  type = object({
    enabled    = optional(bool)
    event_type = string
    project_id = string
    matcher = optional(list(object({
      field_name = string
      operator   = string
      value      = string
    })))
    metric_threshold_config = optional(list(object({
      metric_name = string
      mode        = optional(string)
      operator    = optional(string)
      threshold   = optional(number)
      units       = optional(string)
    })))
    notification = optional(list(object({
      api_token                   = optional(string)
      channel_name                = optional(string)
      datadog_api_key             = optional(string)
      datadog_region              = optional(string)
      delay_min                   = optional(number)
      email_address               = optional(string)
      email_enabled               = optional(bool)
      integration_id              = optional(string)
      interval_min                = optional(number)
      microsoft_teams_webhook_url = optional(string)
      mobile_number               = optional(string)
      notifier_id                 = optional(string)
      ops_genie_api_key           = optional(string)
      ops_genie_region            = optional(string)
      roles                       = optional(list(string))
      service_key                 = optional(string)
      sms_enabled                 = optional(bool)
      team_id                     = optional(string)
      type_name                   = string
      username                    = optional(string)
      victor_ops_api_key          = optional(string)
      victor_ops_routing_key      = optional(string)
      webhook_secret              = optional(string)
      webhook_url                 = optional(string)
    })))
    threshold_config = optional(list(object({
      operator  = optional(string)
      threshold = optional(number)
      units     = optional(string)
    })))
  })
}
