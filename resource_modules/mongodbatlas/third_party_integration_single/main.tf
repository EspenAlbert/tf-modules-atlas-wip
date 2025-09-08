

resource "mongodbatlas_third_party_integration" "this" {
  api_key                          = var.mongodbatlas_third_party_integration.api_key
  channel_name                     = var.mongodbatlas_third_party_integration.channel_name
  enabled                          = var.mongodbatlas_third_party_integration.enabled
  microsoft_teams_webhook_url      = var.mongodbatlas_third_party_integration.microsoft_teams_webhook_url
  password                         = var.mongodbatlas_third_party_integration.password
  project_id                       = var.mongodbatlas_third_party_integration.project_id
  region                           = var.mongodbatlas_third_party_integration.region
  routing_key                      = var.mongodbatlas_third_party_integration.routing_key
  secret                           = var.mongodbatlas_third_party_integration.secret
  send_collection_latency_metrics  = var.mongodbatlas_third_party_integration.send_collection_latency_metrics
  send_database_metrics            = var.mongodbatlas_third_party_integration.send_database_metrics
  send_user_provided_resource_tags = var.mongodbatlas_third_party_integration.send_user_provided_resource_tags
  service_discovery                = var.mongodbatlas_third_party_integration.service_discovery
  service_key                      = var.mongodbatlas_third_party_integration.service_key
  team_name                        = var.mongodbatlas_third_party_integration.team_name
  type                             = var.mongodbatlas_third_party_integration.type
  url                              = var.mongodbatlas_third_party_integration.url
  user_name                        = var.mongodbatlas_third_party_integration.user_name
}

