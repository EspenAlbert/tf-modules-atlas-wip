

resource "mongodbatlas_event_trigger" "this" {
  app_id                      = var.mongodbatlas_event_trigger.app_id
  config_collection           = var.mongodbatlas_event_trigger.config_collection
  config_database             = var.mongodbatlas_event_trigger.config_database
  config_full_document        = var.mongodbatlas_event_trigger.config_full_document
  config_full_document_before = var.mongodbatlas_event_trigger.config_full_document_before
  config_match                = var.mongodbatlas_event_trigger.config_match
  config_operation_type       = var.mongodbatlas_event_trigger.config_operation_type
  config_operation_types      = var.mongodbatlas_event_trigger.config_operation_types
  config_project              = var.mongodbatlas_event_trigger.config_project
  config_providers            = var.mongodbatlas_event_trigger.config_providers
  config_schedule             = var.mongodbatlas_event_trigger.config_schedule
  config_service_id           = var.mongodbatlas_event_trigger.config_service_id
  disabled                    = var.mongodbatlas_event_trigger.disabled
  dynamic "event_processors" {
    for_each = var.mongodbatlas_event_trigger.event_processors == null ? [] : var.mongodbatlas_event_trigger.event_processors
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
  function_id = var.mongodbatlas_event_trigger.function_id
  name        = var.mongodbatlas_event_trigger.name
  project_id  = var.mongodbatlas_event_trigger.project_id
  type        = var.mongodbatlas_event_trigger.type
  unordered   = var.mongodbatlas_event_trigger.unordered
}

