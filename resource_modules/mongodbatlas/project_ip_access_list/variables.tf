variable "project_id" {
  type = string
}

variable "aws_security_group" {
  type     = string
  nullable = true
  default  = null
}

variable "cidr_block" {
  type     = string
  nullable = true
  default  = null
}

variable "comment" {
  type     = string
  nullable = true
  default  = null
}

variable "ip_address" {
  type     = string
  nullable = true
  default  = null
}

variable "timeouts" {
  type = object({
    delete = optional(string)
    read   = optional(string)
  })
  nullable = true
  default  = null
}
