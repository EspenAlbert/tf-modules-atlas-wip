output "atlas_cluster_connection_string" { 
    value = module.atlas_cluster.connection_strings_standard_srv
}

output "project_id" {
  value = module.atlas_project.id
}
