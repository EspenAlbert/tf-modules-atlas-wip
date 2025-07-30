variable "project_id" {
  type     = string
  nullable = true
  default  = null
}

variable "roles" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "username" {
  type     = string
  nullable = true
  default  = null
}
