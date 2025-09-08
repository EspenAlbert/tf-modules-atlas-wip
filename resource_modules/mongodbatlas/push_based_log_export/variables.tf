variable "bucket_name" {
  type = string
}

variable "iam_role_id" {
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

variable "prefix_path" {
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
