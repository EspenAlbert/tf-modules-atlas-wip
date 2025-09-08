

resource "mongodbatlas_cluster_outage_simulation" "this" {
  cluster_name             = var.cluster_name
  delete_on_create_timeout = var.delete_on_create_timeout
  dynamic "outage_filters" {
    for_each = var.outage_filters == null ? [] : var.outage_filters
    content {
      cloud_provider = outage_filters.value.cloud_provider
      region_name    = outage_filters.value.region_name
    }
  }
  project_id = var.project_id
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

