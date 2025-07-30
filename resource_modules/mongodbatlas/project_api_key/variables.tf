variable "description" {
  type     = string
  nullable = true
  default  = null
}

variable "project_assignment" {
  type = set(object({
    project_id = string
    role_names = list(string)
  }))
  nullable = true
  default  = null
}
