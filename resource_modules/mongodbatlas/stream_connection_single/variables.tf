variable "mongodbatlas_stream_connection" {
  type = object({
    authentication = optional(object({
      mechanism = optional(string)
      password  = optional(string)
      username  = optional(string)
    }))
    aws = optional(object({
      role_arn = string
    }))
    bootstrap_servers  = optional(string)
    cluster_name       = optional(string)
    cluster_project_id = optional(string)
    config             = optional(map(any))
    connection_name    = string
    db_role_to_execute = optional(object({
      role = string
      type = string
    }))
    headers       = optional(map(any))
    instance_name = string
    networking = optional(object({
      access = object({
        connection_id = optional(string)
        type          = string
      })
    }))
    project_id = string
    security = optional(object({
      broker_public_certificate = optional(string)
      protocol                  = optional(string)
    }))
    type = string
    url  = optional(string)
  })
}
