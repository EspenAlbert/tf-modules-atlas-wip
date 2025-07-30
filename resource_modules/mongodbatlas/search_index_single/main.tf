

resource "mongodbatlas_search_index" "this" {
  analyzer         = var.mongodbatlas_search_index.analyzer
  analyzers        = var.mongodbatlas_search_index.analyzers
  cluster_name     = var.mongodbatlas_search_index.cluster_name
  collection_name  = var.mongodbatlas_search_index.collection_name
  database         = var.mongodbatlas_search_index.database
  fields           = var.mongodbatlas_search_index.fields
  mappings_dynamic = var.mongodbatlas_search_index.mappings_dynamic
  mappings_fields  = var.mongodbatlas_search_index.mappings_fields
  name             = var.mongodbatlas_search_index.name
  project_id       = var.mongodbatlas_search_index.project_id
  search_analyzer  = var.mongodbatlas_search_index.search_analyzer
  stored_source    = var.mongodbatlas_search_index.stored_source
  dynamic "synonyms" {
    for_each = var.mongodbatlas_search_index.synonyms == null ? [] : var.mongodbatlas_search_index.synonyms
    content {
      analyzer          = synonyms.value.analyzer
      name              = synonyms.value.name
      source_collection = synonyms.value.source_collection
    }
  }
  dynamic "timeouts" {
    for_each = var.mongodbatlas_search_index.timeouts == null ? [] : [var.mongodbatlas_search_index.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
  type                            = var.mongodbatlas_search_index.type
  wait_for_index_build_completion = var.mongodbatlas_search_index.wait_for_index_build_completion
}

