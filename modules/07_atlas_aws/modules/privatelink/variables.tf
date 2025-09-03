variable "project_id" {
  type = string
}
# Atlas Region
variable "atlas_region" {
  type = string
  validation {
    condition     = length(var.atlas_region) > 0
    error_message = "atlas_region must be provided"
  }
}

variable "existing_vpc_endpoint_id" {
  type     = string
  nullable = false
  default  = ""
}

variable "add_vpc_cidr_block_project_access" {
  type    = bool
  default = false
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

variable "aws_tags" {
  type        = map(string)
  description = "aws tags"
  default     = {}
}
