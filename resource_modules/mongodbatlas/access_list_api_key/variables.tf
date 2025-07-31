variable "api_key_id" {
  type = string
}

variable "org_id" {
  type = string
}

variable "cidr_block" {
  type     = string
  nullable = true
  default  = null
}

variable "ip_address" {
  type     = string
  nullable = true
  default  = null
}
