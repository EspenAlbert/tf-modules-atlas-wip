output "cluster_id" {
  value = mongodbatlas_cloud_backup_schedule.this.cluster_id
}

output "id_policy" {
  value = mongodbatlas_cloud_backup_schedule.this.id_policy
}

output "next_snapshot" {
  value = mongodbatlas_cloud_backup_schedule.this.next_snapshot
}
output "policy_item_daily_frequency_type" {
  value = mongodbatlas_cloud_backup_schedule.this.policy_item_daily == null ? null : mongodbatlas_cloud_backup_schedule.this.policy_item_daily[*].frequency_type
}

output "policy_item_hourly_frequency_type" {
  value = mongodbatlas_cloud_backup_schedule.this.policy_item_hourly == null ? null : mongodbatlas_cloud_backup_schedule.this.policy_item_hourly[*].frequency_type
}

output "policy_item_monthly_frequency_type" {
  value = mongodbatlas_cloud_backup_schedule.this.policy_item_monthly == null ? null : mongodbatlas_cloud_backup_schedule.this.policy_item_monthly[*].frequency_type
}

output "policy_item_weekly_frequency_type" {
  value = mongodbatlas_cloud_backup_schedule.this.policy_item_weekly == null ? null : mongodbatlas_cloud_backup_schedule.this.policy_item_weekly[*].frequency_type
}

output "policy_item_yearly_frequency_type" {
  value = mongodbatlas_cloud_backup_schedule.this.policy_item_yearly == null ? null : mongodbatlas_cloud_backup_schedule.this.policy_item_yearly[*].frequency_type
}
