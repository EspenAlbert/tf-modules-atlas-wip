variable "cluster_name" {
  type = string
}

variable "collection_name" {
  type = string
}

variable "database" {
  type = string
}

variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "analyzer" {
  type     = string
  nullable = true
  default  = null
}

variable "analyzers" {
  type     = string
  nullable = true
  default  = null
}

variable "fields" {
  type     = string
  nullable = true
  default  = null
}

variable "mappings_dynamic" {
  type     = bool
  nullable = true
  default  = null
}

variable "mappings_fields" {
  type     = string
  nullable = true
  default  = null
}

variable "search_analyzer" {
  type     = string
  nullable = true
  default  = null
}

variable "stored_source" {
  type     = string
  nullable = true
  default  = null
}

variable "synonyms" {
  type = set(object({
    analyzer          = string
    name              = string
    source_collection = string
  }))
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  nullable = true
  default  = null
}

variable "type" {
  type     = string
  nullable = true
  default  = null
}

variable "wait_for_index_build_completion" {
  type     = bool
  nullable = true
  default  = null
}
