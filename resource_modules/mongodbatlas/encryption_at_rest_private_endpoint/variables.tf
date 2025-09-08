variable "cloud_provider" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region_name" {
  type = string
}

variable "delete_on_create_timeout" {
  type     = bool
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
