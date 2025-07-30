variable "mongodbatlas_custom_db_role" {
  type = object({
    project_id = string
    role_name  = string
    actions = optional(list(object({
      action = string
      resources = set(object({
        cluster         = optional(bool)
        collection_name = optional(string)
        database_name   = optional(string)
      }))
    })))
    inherited_roles = optional(set(object({
      database_name = string
      role_name     = string
    })))
  })
}
