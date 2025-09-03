variable "dev_ips" {
  type = map(object({
    comment = string
    ip_address = string
  }))
  default = {}
}
