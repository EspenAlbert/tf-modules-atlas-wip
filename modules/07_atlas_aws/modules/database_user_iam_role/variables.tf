variable "project_id" {
  type = string
}

variable "description" {
  type = string
}

variable "existing_role_arn" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "roles" {
  type = set(object({
    collection_name = optional(string)
    database_name   = optional(string)
    role_name       = string
  }))
  default = []
}

variable "scopes" {
  type = set(object({
    name = string
    type = string
  }))
  default = []
}
