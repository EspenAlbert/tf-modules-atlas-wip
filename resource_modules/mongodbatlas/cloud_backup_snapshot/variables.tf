variable "cluster_name" {
  type = string
}

variable "description" {
  type = string
}

variable "project_id" {
  type = string
}

variable "retention_in_days" {
  type = number
}

variable "delete_on_create_timeout" {
  type     = bool
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    create = optional(string)
  })
  nullable = true
  default  = null
}
