variable "mongodbatlas_project_ip_access_list" {
  type = object({
    aws_security_group = optional(string)
    cidr_block         = optional(string)
    comment            = optional(string)
    ip_address         = optional(string)
    project_id         = string
    timeouts = optional(object({
      delete = optional(string)
      read   = optional(string)
    }))
  })
}
