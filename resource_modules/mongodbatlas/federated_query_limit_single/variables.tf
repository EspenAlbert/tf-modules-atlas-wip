variable "mongodbatlas_federated_query_limit" {
  type = object({
    default_limit  = optional(number)
    limit_name     = string
    maximum_limit  = optional(number)
    overrun_policy = string
    project_id     = string
    tenant_name    = string
    value          = number
  })
}
