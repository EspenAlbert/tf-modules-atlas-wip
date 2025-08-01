variable "project_id" {
  type = string
}
# Atlas Region
variable "atlas_region" {
  type = string
}

variable "aws_private_endpoint" {
  type = object({
    vpc_id                        = string
    subnet_ids                    = set(string)
    security_group_ids            = set(string)
    add_cidr_block_project_access = optional(bool, true)
  })
  default  = null
  nullable = true
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "aws_private_endpoint_encryption_at_rest" {
  type = object({
    enabled = bool
  })
  nullable = false
  default = {
    enabled = false
  }
}
