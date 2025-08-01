# Outputs to Display
output "atlas_cluster_connection_string" {
  value = mongodbatlas_advanced_cluster.atlas_cluster.connection_strings.standard_srv
}
output "project_id" { value = mongodbatlas_project.atlas_project.id }
