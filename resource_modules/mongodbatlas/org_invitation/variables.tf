variable "org_id" {
  type     = string
  nullable = true
  default  = null
}

variable "roles" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "teams_ids" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "username" {
  type     = string
  nullable = true
  default  = null
}
