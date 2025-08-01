
# Atlas Region
variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "atlas_project_id" {
  type = string
}


variable "environment" {
  type = string
}
