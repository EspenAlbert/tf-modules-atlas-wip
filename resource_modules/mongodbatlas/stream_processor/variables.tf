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
