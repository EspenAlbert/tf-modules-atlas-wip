variable "mongodbatlas_search_index" {
  type = object({
    analyzer                        = optional(string)
    analyzers                       = optional(string)
    cluster_name                    = string
    collection_name                 = string
    database                        = string
    fields                          = optional(string)
    mappings_dynamic                = optional(bool)
    mappings_fields                 = optional(string)
    name                            = string
    project_id                      = string
    search_analyzer                 = optional(string)
    stored_source                   = optional(string)
    type                            = optional(string)
    wait_for_index_build_completion = optional(bool)
    synonyms = optional(set(object({
      analyzer          = string
      name              = string
      source_collection = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
}
