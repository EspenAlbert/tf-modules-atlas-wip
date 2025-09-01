output "atlas_project" {
  value = module.atlas_project
}
output "cloud_provider_aws" {
  value = module.cloud_provider_aws
}
output "atlas_aws" {
  value = module.atlas_aws
}
output "auth_db" {
  value = module.auth_db
}
output "networking_aws" {
  value = module.networking_aws
}
output "atlas_cluster" {
  value = module.atlas_cluster
}
output "alert_configuration" {
  value = {
    alert_configuration_id = module.alert_configuration.alert_configuration_id
    created                = module.alert_configuration.created
    updated                = module.alert_configuration.updated
  }
}
output "automated_backup_test_cluster" {
  value = module.automated_backup_test_cluster
}
