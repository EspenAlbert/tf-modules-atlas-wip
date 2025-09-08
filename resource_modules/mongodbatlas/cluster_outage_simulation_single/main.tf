

resource "mongodbatlas_cluster_outage_simulation" "this" {
  cluster_name             = var.mongodbatlas_cluster_outage_simulation.cluster_name
  delete_on_create_timeout = var.mongodbatlas_cluster_outage_simulation.delete_on_create_timeout
  dynamic "outage_filters" {
    for_each = var.mongodbatlas_cluster_outage_simulation.outage_filters == null ? [] : var.mongodbatlas_cluster_outage_simulation.outage_filters
    content {
      cloud_provider = outage_filters.value.cloud_provider
      region_name    = outage_filters.value.region_name
    }
  }
  project_id = var.mongodbatlas_cluster_outage_simulation.project_id
  dynamic "timeouts" {
    for_each = var.mongodbatlas_cluster_outage_simulation.timeouts == null ? [] : [var.mongodbatlas_cluster_outage_simulation.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

