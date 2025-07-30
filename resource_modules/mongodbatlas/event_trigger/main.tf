

resource "mongodbatlas_event_trigger" "this" {
  app_id                      = var.app_id
  config_collection           = var.config_collection
  config_database             = var.config_database
  config_full_document        = var.config_full_document
  config_full_document_before = var.config_full_document_before
  config_match                = var.config_match
  config_operation_type       = var.config_operation_type
  config_operation_types      = var.config_operation_types
  config_project              = var.config_project
  config_providers            = var.config_providers
  config_schedule             = var.config_schedule
  config_service_id           = var.config_service_id
  disabled                    = var.disabled
  dynamic "event_processors" {
    for_each = var.event_processors == null ? [] : var.event_processors
    content {
      dynamic "aws_eventbridge" {
        for_each = event_processors.value.aws_eventbridge == null ? [] : event_processors.value.aws_eventbridge
        content {
          config_account_id = aws_eventbridge.value.config_account_id
          config_region     = aws_eventbridge.value.config_region
        }
      }
    }
  }
  function_id = var.function_id
  name        = var.name
  project_id  = var.project_id
  type        = var.type
  unordered   = var.unordered
}

