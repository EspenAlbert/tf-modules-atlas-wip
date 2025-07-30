variable "atlas_cidr_block" {
  type     = string
  nullable = true
  default  = null
}

variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "provider_name" {
  type     = string
  nullable = true
  default  = null
}

variable "region" {
  type     = string
  nullable = true
  default  = null
}

variable "region_name" {
  type     = string
  nullable = true
  default  = null
}

variable "regions" {
  type     = list(string)
  nullable = true
  default  = null
}
