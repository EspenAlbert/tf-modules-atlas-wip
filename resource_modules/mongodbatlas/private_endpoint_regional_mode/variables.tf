variable "enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
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
