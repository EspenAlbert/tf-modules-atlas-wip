output "number_of_deferrals" {
  value = mongodbatlas_maintenance_window.this.number_of_deferrals
}

output "start_asap" {
  value = mongodbatlas_maintenance_window.this.start_asap
}

output "time_zone_id" {
  value = mongodbatlas_maintenance_window.this.time_zone_id
}
