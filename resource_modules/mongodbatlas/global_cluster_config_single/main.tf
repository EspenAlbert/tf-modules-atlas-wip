

resource "mongodbatlas_global_cluster_config" "this" {
  cluster_name = var.mongodbatlas_global_cluster_config.cluster_name
  dynamic "custom_zone_mappings" {
    for_each = var.mongodbatlas_global_cluster_config.custom_zone_mappings == null ? [] : var.mongodbatlas_global_cluster_config.custom_zone_mappings
    content {
      location = custom_zone_mappings.value.location
      zone     = custom_zone_mappings.value.zone
    }
  }
  dynamic "managed_namespaces" {
    for_each = var.mongodbatlas_global_cluster_config.managed_namespaces == null ? [] : var.mongodbatlas_global_cluster_config.managed_namespaces
    content {
      collection                 = managed_namespaces.value.collection
      custom_shard_key           = managed_namespaces.value.custom_shard_key
      db                         = managed_namespaces.value.db
      is_custom_shard_key_hashed = managed_namespaces.value.is_custom_shard_key_hashed
      is_shard_key_unique        = managed_namespaces.value.is_shard_key_unique
    }
  }
  project_id = var.mongodbatlas_global_cluster_config.project_id
}

