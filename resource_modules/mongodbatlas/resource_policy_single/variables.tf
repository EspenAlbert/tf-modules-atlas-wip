variable "mongodbatlas_resource_policy" {
  type = object({
    description = optional(string)
    name        = string
    org_id      = string
    policies = list(object({
      body = string
    }))
  })
}
