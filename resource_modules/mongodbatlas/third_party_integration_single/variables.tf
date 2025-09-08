variable "mongodbatlas_third_party_integration" {
  type = object({
    api_key                          = optional(string)
    channel_name                     = optional(string)
    enabled                          = optional(bool)
    microsoft_teams_webhook_url      = optional(string)
    password                         = optional(string)
    project_id                       = string
    region                           = optional(string)
    routing_key                      = optional(string)
    secret                           = optional(string)
    send_collection_latency_metrics  = optional(bool)
    send_database_metrics            = optional(bool)
    send_user_provided_resource_tags = optional(bool)
    service_discovery                = optional(string)
    service_key                      = optional(string)
    team_name                        = optional(string)
    type                             = string
    url                              = optional(string)
    user_name                        = optional(string)
  })
}
