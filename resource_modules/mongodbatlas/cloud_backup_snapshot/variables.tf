variable "cluster_name" {
  type = string
}

variable "description" {
  type = string
}

variable "project_id" {
  type = string
}

variable "retention_in_days" {
  type = number
}

variable "timeouts" {
  type = object({
    create = optional(string)
  })
  nullable = true
  default  = null
}
