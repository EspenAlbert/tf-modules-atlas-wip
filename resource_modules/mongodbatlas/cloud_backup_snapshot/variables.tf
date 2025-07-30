variable "cluster_name" {
  type     = string
  nullable = true
  default  = null
}

variable "description" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "retention_in_days" {
  type     = number
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
