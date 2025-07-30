output "state" {
  value = mongodbatlas_backup_compliance_policy.this.state
}

output "updated_date" {
  value = mongodbatlas_backup_compliance_policy.this.updated_date
}

output "updated_user" {
  value = mongodbatlas_backup_compliance_policy.this.updated_user
}
output "on_demand_policy_item_frequency_type" {
  value = mongodbatlas_backup_compliance_policy.this.on_demand_policy_item == null ? null : mongodbatlas_backup_compliance_policy.this.on_demand_policy_item[*].frequency_type
}

output "on_demand_policy_item_retention_unit" {
  value = mongodbatlas_backup_compliance_policy.this.on_demand_policy_item == null ? null : mongodbatlas_backup_compliance_policy.this.on_demand_policy_item[*].retention_unit
}

output "policy_item_daily_frequency_type" {
  value = mongodbatlas_backup_compliance_policy.this.policy_item_daily == null ? null : mongodbatlas_backup_compliance_policy.this.policy_item_daily[*].frequency_type
}

output "policy_item_hourly_frequency_type" {
  value = mongodbatlas_backup_compliance_policy.this.policy_item_hourly == null ? null : mongodbatlas_backup_compliance_policy.this.policy_item_hourly[*].frequency_type
}

output "policy_item_monthly_frequency_type" {
  value = mongodbatlas_backup_compliance_policy.this.policy_item_monthly == null ? null : mongodbatlas_backup_compliance_policy.this.policy_item_monthly[*].frequency_type
}

output "policy_item_weekly_frequency_type" {
  value = mongodbatlas_backup_compliance_policy.this.policy_item_weekly == null ? null : mongodbatlas_backup_compliance_policy.this.policy_item_weekly[*].frequency_type
}

output "policy_item_yearly_frequency_type" {
  value = mongodbatlas_backup_compliance_policy.this.policy_item_yearly == null ? null : mongodbatlas_backup_compliance_policy.this.policy_item_yearly[*].frequency_type
}

output "policy_item_yearly_retention_unit" {
  value = mongodbatlas_backup_compliance_policy.this.policy_item_yearly == null ? null : mongodbatlas_backup_compliance_policy.this.policy_item_yearly[*].retention_unit
}
