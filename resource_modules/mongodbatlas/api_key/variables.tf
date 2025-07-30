variable "description" {
  type     = string
  nullable = true
  default  = null
}

variable "org_id" {
  type     = string
  nullable = true
  default  = null
}

variable "role_names" {
  type     = list(string)
  nullable = true
  default  = null
}
