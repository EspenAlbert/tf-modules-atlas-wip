variable "instance_name" {
  type = string
}

variable "pipeline" {
  type = string
}

variable "processor_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "delete_on_create_timeout" {
  type     = bool
  nullable = true
  default  = null
}

variable "options" {
  type = object({
    dlq = object({
      coll            = string
      connection_name = string
      db              = string
    })
  })
  nullable = true
  default  = null
}

variable "state" {
  type     = string
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
