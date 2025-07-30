variable "authentication" {
  type = object({
    mechanism = optional(string)
    password  = optional(string)
    username  = optional(string)
  })
  nullable = true
  default  = null
}

variable "aws" {
  type = object({
    role_arn = string
  })
  nullable = true
  default  = null
}

variable "bootstrap_servers" {
  type     = string
  nullable = true
  default  = null
}

variable "cluster_name" {
  type     = string
  nullable = true
  default  = null
}

variable "cluster_project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "config" {
  type     = map(any)
  nullable = true
  default  = null
}

variable "connection_name" {
  type     = string
  nullable = true
  default  = null
}

variable "db_role_to_execute" {
  type = object({
    role = string
    type = string
  })
  nullable = true
  default  = null
}

variable "headers" {
  type     = map(any)
  nullable = true
  default  = null
}

variable "instance_name" {
  type     = string
  nullable = true
  default  = null
}

variable "networking" {
  type = object({
    access = object({
      connection_id = optional(string)
      type          = string
    })
  })
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "security" {
  type = object({
    broker_public_certificate = optional(string)
    protocol                  = optional(string)
  })
  nullable = true
  default  = null
}

variable "type" {
  type     = string
  nullable = true
  default  = null
}

variable "url" {
  type     = string
  nullable = true
  default  = null
}
