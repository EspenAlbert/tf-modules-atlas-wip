variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_name" {
  type     = string
  nullable = true
  default  = null
}

variable "region" {
  type     = string
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
  })
  nullable = true
  default  = null
}
