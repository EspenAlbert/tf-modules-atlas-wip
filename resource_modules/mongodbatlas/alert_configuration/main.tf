

resource "mongodbatlas_alert_configuration" "this" {
  enabled    = var.enabled
  event_type = var.event_type
  dynamic "matcher" {
    for_each = var.matcher == null ? [] : var.matcher
    content {
      field_name = matcher.value.field_name
      operator   = matcher.value.operator
      value      = matcher.value.value
    }
  }
  dynamic "metric_threshold_config" {
    for_each = var.metric_threshold_config == null ? [] : var.metric_threshold_config
    content {
      metric_name = metric_threshold_config.value.metric_name
      mode        = metric_threshold_config.value.mode
      operator    = metric_threshold_config.value.operator
      threshold   = metric_threshold_config.value.threshold
      units       = metric_threshold_config.value.units
    }
  }
  dynamic "notification" {
    for_each = var.notification == null ? [] : var.notification
    content {
      api_token                   = notification.value.api_token
      channel_name                = notification.value.channel_name
      datadog_api_key             = notification.value.datadog_api_key
      datadog_region              = notification.value.datadog_region
      delay_min                   = notification.value.delay_min
      email_address               = notification.value.email_address
      email_enabled               = notification.value.email_enabled
      integration_id              = notification.value.integration_id
      interval_min                = notification.value.interval_min
      microsoft_teams_webhook_url = notification.value.microsoft_teams_webhook_url
      mobile_number               = notification.value.mobile_number
      notifier_id                 = notification.value.notifier_id
      ops_genie_api_key           = notification.value.ops_genie_api_key
      ops_genie_region            = notification.value.ops_genie_region
      roles                       = notification.value.roles
      service_key                 = notification.value.service_key
      sms_enabled                 = notification.value.sms_enabled
      team_id                     = notification.value.team_id
      type_name                   = notification.value.type_name
      username                    = notification.value.username
      victor_ops_api_key          = notification.value.victor_ops_api_key
      victor_ops_routing_key      = notification.value.victor_ops_routing_key
      webhook_secret              = notification.value.webhook_secret
      webhook_url                 = notification.value.webhook_url
    }
  }
  project_id = var.project_id
  dynamic "threshold_config" {
    for_each = var.threshold_config == null ? [] : var.threshold_config
    content {
      operator  = threshold_config.value.operator
      threshold = threshold_config.value.threshold
      units     = threshold_config.value.units
    }
  }
}

