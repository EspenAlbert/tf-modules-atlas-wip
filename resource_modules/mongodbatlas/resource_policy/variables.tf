variable "name" {
  type = string
}

variable "org_id" {
  type = string
}

variable "policies" {
  type = list(object({
    body = string
  }))
}

variable "description" {
  type     = string
  nullable = true
  default  = null
}
