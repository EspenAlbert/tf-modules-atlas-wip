variable "event_type" {
  type = string
}

variable "project_id" {
  type = string
}

variable "enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "matcher" {
  type = list(object({
    field_name = string
    operator   = string
    value      = string
  }))
  nullable = true
  default  = null
}

variable "metric_threshold_config" {
  type = list(object({
    metric_name = string
    mode        = optional(string)
    operator    = optional(string)
    threshold   = optional(number)
    units       = optional(string)
  }))
  nullable = true
  default  = null
}

variable "notification" {
  type = list(object({
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
  }))
  nullable = true
  default  = null
}

variable "threshold_config" {
  type = list(object({
    operator  = optional(string)
    threshold = optional(number)
    units     = optional(string)
  }))
  nullable = true
  default  = null
}
