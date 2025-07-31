variable "project_id" {
  type = string
}

variable "customer_x509_cas" {
  type     = string
  nullable = true
  default  = null
}

variable "months_until_expiration" {
  type     = number
  nullable = true
  default  = null
}

variable "username" {
  type     = string
  nullable = true
  default  = null
}
