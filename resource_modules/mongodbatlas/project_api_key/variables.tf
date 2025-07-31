variable "description" {
  type = string
}

variable "project_assignment" {
  type = set(object({
    project_id = string
    role_names = list(string)
  }))
}
