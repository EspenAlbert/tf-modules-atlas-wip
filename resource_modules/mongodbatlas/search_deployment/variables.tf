variable "cluster_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "specs" {
  type = list(object({
    instance_size = string
    node_count    = number
  }))
}

variable "delete_on_create_timeout" {
  type     = bool
  nullable = true
  default  = null
}

variable "skip_wait_on_update" {
  type     = bool
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
