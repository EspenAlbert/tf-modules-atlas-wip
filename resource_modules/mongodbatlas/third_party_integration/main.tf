

resource "mongodbatlas_third_party_integration" "this" {
  api_key                          = var.api_key
  channel_name                     = var.channel_name
  enabled                          = var.enabled
  microsoft_teams_webhook_url      = var.microsoft_teams_webhook_url
  password                         = var.password
  project_id                       = var.project_id
  region                           = var.region
  routing_key                      = var.routing_key
  secret                           = var.secret
  send_collection_latency_metrics  = var.send_collection_latency_metrics
  send_database_metrics            = var.send_database_metrics
  send_user_provided_resource_tags = var.send_user_provided_resource_tags
  service_discovery                = var.service_discovery
  service_key                      = var.service_key
  team_name                        = var.team_name
  type                             = var.type
  url                              = var.url
  user_name                        = var.user_name
}

