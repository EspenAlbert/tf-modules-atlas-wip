variable "project_id" {
  type = string
}

variable "type" {
  type = string
}

variable "api_key" {
  type     = string
  nullable = true
  default  = null
}

variable "channel_name" {
  type     = string
  nullable = true
  default  = null
}

variable "enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "microsoft_teams_webhook_url" {
  type     = string
  nullable = true
  default  = null
}

variable "password" {
  type     = string
  nullable = true
  default  = null
}

variable "region" {
  type     = string
  nullable = true
  default  = null
}

variable "routing_key" {
  type     = string
  nullable = true
  default  = null
}

variable "secret" {
  type     = string
  nullable = true
  default  = null
}

variable "send_collection_latency_metrics" {
  type     = bool
  nullable = true
  default  = null
}

variable "send_database_metrics" {
  type     = bool
  nullable = true
  default  = null
}

variable "send_user_provided_resource_tags" {
  type     = bool
  nullable = true
  default  = null
}

variable "service_discovery" {
  type     = string
  nullable = true
  default  = null
}

variable "service_key" {
  type     = string
  nullable = true
  default  = null
}

variable "team_name" {
  type     = string
  nullable = true
  default  = null
}

variable "url" {
  type     = string
  nullable = true
  default  = null
}

variable "user_name" {
  type     = string
  nullable = true
  default  = null
}
