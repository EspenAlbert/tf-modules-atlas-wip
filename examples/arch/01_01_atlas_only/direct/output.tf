# Outputs to Display
output "atlas_cluster_connection_string" { value = mongodbatlas_advanced_cluster.atlas-cluster.connection_strings.standard_srv }
output "project_id" { value = mongodbatlas_project.atlas-project.id }
