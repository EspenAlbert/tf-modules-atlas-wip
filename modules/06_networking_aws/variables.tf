variable "project_id" {
  type = string
}
# Atlas Region
variable "atlas_region" {
  type = string
}

variable "aws_private_endpoint" {
  type = object({
    vpc_id             = string
    subnet_ids         = set(string)
    security_group_ids = set(string)
  })
  default  = null
  nullable = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
