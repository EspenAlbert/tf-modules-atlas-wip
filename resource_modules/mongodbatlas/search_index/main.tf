

resource "mongodbatlas_search_index" "this" {
  analyzer         = var.analyzer
  analyzers        = var.analyzers
  cluster_name     = var.cluster_name
  collection_name  = var.collection_name
  database         = var.database
  fields           = var.fields
  mappings_dynamic = var.mappings_dynamic
  mappings_fields  = var.mappings_fields
  name             = var.name
  project_id       = var.project_id
  search_analyzer  = var.search_analyzer
  stored_source    = var.stored_source
  dynamic "synonyms" {
    for_each = var.synonyms == null ? [] : var.synonyms
    content {
      analyzer          = synonyms.value.analyzer
      name              = synonyms.value.name
      source_collection = synonyms.value.source_collection
    }
  }
  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
  type                            = var.type
  wait_for_index_build_completion = var.wait_for_index_build_completion
}

