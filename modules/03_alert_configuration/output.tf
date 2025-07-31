output "alert_configuration_id" {
  value = mongodbatlas_alert_configuration.this.alert_configuration_id
}

output "created" {
  value = mongodbatlas_alert_configuration.this.created
}

output "updated" {
  value = mongodbatlas_alert_configuration.this.updated
}
output "notification_team_name" {
  value = mongodbatlas_alert_configuration.this.notification == null ? null : mongodbatlas_alert_configuration.this.notification[*].team_name
}
