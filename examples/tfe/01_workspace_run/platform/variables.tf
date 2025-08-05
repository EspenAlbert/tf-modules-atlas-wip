variable "app_workspace" {
    default = ""
}
variable "tfe_org" {
    type = string
}

variable "aws_region" {
  type        = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
}
