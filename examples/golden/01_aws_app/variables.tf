# source/includes/examples/tf-example-variables.rst
variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

variable "cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
}

variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
}

variable "mongodb_version" {
  type        = string
  description = "MongoDB Version"
}

variable "aws_iam_role_name" {
  type        = string
  description = "Created to be used by the atlas cloud provider"
}

# AWS VPC config
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "aws_iam_role_arn_ec2" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resources"
  default     = {}
}
