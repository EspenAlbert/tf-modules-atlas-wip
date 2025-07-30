variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "role_name" {
  type     = string
  nullable = true
  default  = null
}

variable "actions" {
  type = list(object({
    action = string
    resources = set(object({
      cluster         = optional(bool)
      collection_name = optional(string)
      database_name   = optional(string)
    }))
  }))
  nullable = true
  default  = null
}

variable "inherited_roles" {
  type = set(object({
    database_name = string
    role_name     = string
  }))
  nullable = true
  default  = null
}
