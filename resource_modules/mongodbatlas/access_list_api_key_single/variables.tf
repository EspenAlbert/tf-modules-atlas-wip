variable "mongodbatlas_access_list_api_key" {
  type = object({
    api_key_id = string
    cidr_block = optional(string)
    ip_address = optional(string)
    org_id     = string
  })
}
