output "simulation_id" {
  value = mongodbatlas_cluster_outage_simulation.this.simulation_id
}

output "start_request_date" {
  value = mongodbatlas_cluster_outage_simulation.this.start_request_date
}

output "state" {
  value = mongodbatlas_cluster_outage_simulation.this.state
}
output "outage_filters_type" {
  value = mongodbatlas_cluster_outage_simulation.this.outage_filters[*].type
}
