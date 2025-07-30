variable "description" {
  type     = string
  nullable = true
  default  = null
}

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

variable "policies" {
  type = list(object({
    body = string
  }))
  nullable = true
  default  = null
}
