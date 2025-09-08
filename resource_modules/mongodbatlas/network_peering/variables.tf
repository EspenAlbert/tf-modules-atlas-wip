variable "container_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "provider_name" {
  type = string
}

variable "accepter_region_name" {
  type     = string
  nullable = true
  default  = null
}

variable "atlas_cidr_block" {
  type     = string
  nullable = true
  default  = null
}

variable "atlas_gcp_project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "atlas_vpc_name" {
  type     = string
  nullable = true
  default  = null
}

variable "aws_account_id" {
  type     = string
  nullable = true
  default  = null
}

variable "azure_directory_id" {
  type     = string
  nullable = true
  default  = null
}

variable "azure_subscription_id" {
  type     = string
  nullable = true
  default  = null
}

variable "delete_on_create_timeout" {
  type     = bool
  nullable = true
  default  = null
}

variable "gcp_project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "network_name" {
  type     = string
  nullable = true
  default  = null
}

variable "resource_group_name" {
  type     = string
  nullable = true
  default  = null
}

variable "route_table_cidr_block" {
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

variable "vnet_name" {
  type     = string
  nullable = true
  default  = null
}

variable "vpc_id" {
  type     = string
  nullable = true
  default  = null
}
