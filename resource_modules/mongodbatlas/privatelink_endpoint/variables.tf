variable "project_id" {
  type = string
}

variable "provider_name" {
  type = string
}

variable "region" {
  type = string
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
  })
  nullable = true
  default  = null
}
