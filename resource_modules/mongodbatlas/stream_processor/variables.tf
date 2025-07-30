variable "instance_name" {
  type     = string
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

variable "pipeline" {
  type     = string
  nullable = true
  default  = null
}

variable "processor_name" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "state" {
  type     = string
  nullable = true
  default  = null
}
