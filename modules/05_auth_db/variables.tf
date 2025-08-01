variable "project_id" {
  type = string
}

variable "aws_iam_role_database_users" {
  type = list(object({
    description = optional(string)
    role_arn    = string
    labels = optional(set(object({
      key   = optional(string)
      value = optional(string)
    })))
    roles = set(object({
      collection_name = optional(string)
      database_name   = string
      role_name       = string
    }))
    scopes = optional(set(object({
      name = optional(string)
      type = optional(string)
    })))
  }))
  default = []
}


variable "custom_db_roles" {
  type = map(object({
    actions = optional(map(set(object({
      cluster         = optional(bool)
      collection_name = optional(string)
      database_name   = optional(string)
    }))))
    inherited_roles = optional(set(object({
      database_name = string
      role_name     = string
    })))
  }))
}
