variable "org_id" {
  type = string
}

variable "roles" {
  type = list(string)
}

variable "username" {
  type = string
}

variable "teams_ids" {
  type     = list(string)
  nullable = true
  default  = null
}
