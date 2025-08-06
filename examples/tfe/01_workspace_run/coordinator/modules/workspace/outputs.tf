output "workspace_id" {
  description = "The ID of the created workspace"
  value       = tfe_workspace.this.id
}

output "workspace_name" {
  description = "The name of the created workspace"
  value       = tfe_workspace.this.name
}

output "workspace" {
  description = "The workspace resource"
  value       = tfe_workspace.this
}
