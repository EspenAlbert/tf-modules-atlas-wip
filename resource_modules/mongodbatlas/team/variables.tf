variable "name" {
  type     = string
  nullable = true
  default  = null
}

variable "org_id" {
  type     = string
  nullable = true
  default  = null
}

variable "usernames" {
  type     = list(string)
  nullable = true
  default  = null
}
