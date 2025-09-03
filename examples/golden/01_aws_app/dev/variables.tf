# source/includes/examples/tf-example-variables.rst
variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

variable "dev_ips" {
  type = map(object({
    comment    = string
    ip_address = string
  }))
  default = {}
}
variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
}


# AWS VPC config
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "aws_iam_role_app_name" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resources"
  default     = {}
}
