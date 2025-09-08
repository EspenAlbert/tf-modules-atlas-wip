variable "org_id" {
  type = string
}

variable "roles" {
  type = object({
    org_roles = optional(list(string))
  })
}

variable "username" {
  type = string
}
