

resource "mongodbatlas_online_archive" "this" {
  cluster_name    = var.cluster_name
  coll_name       = var.coll_name
  collection_type = var.collection_type
  dynamic "criteria" {
    for_each = var.criteria == null ? [] : var.criteria
    content {
      date_field        = criteria.value.date_field
      date_format       = criteria.value.date_format
      expire_after_days = criteria.value.expire_after_days
      query             = criteria.value.query
      type              = criteria.value.type
    }
  }
  dynamic "data_expiration_rule" {
    for_each = var.data_expiration_rule == null ? [] : var.data_expiration_rule
    content {
      expire_after_days = data_expiration_rule.value.expire_after_days
    }
  }
  dynamic "data_process_region" {
    for_each = var.data_process_region == null ? [] : var.data_process_region
    content {
      cloud_provider = data_process_region.value.cloud_provider
      region         = data_process_region.value.region
    }
  }
  db_name = var.db_name
  dynamic "partition_fields" {
    for_each = var.partition_fields == null ? [] : var.partition_fields
    content {
      field_name = partition_fields.value.field_name
      order      = partition_fields.value.order
    }
  }
  paused     = var.paused
  project_id = var.project_id
  dynamic "schedule" {
    for_each = var.schedule == null ? [] : var.schedule
    content {
      day_of_month = schedule.value.day_of_month
      day_of_week  = schedule.value.day_of_week
      end_hour     = schedule.value.end_hour
      end_minute   = schedule.value.end_minute
      start_hour   = schedule.value.start_hour
      start_minute = schedule.value.start_minute
      type         = schedule.value.type
    }
  }
  sync_creation = var.sync_creation
}

