output "country" {
  value = mongodbatlas_cloud_user_team_assignment.this.country
}

output "created_at" {
  value = mongodbatlas_cloud_user_team_assignment.this.created_at
}

output "first_name" {
  value = mongodbatlas_cloud_user_team_assignment.this.first_name
}

output "invitation_created_at" {
  value = mongodbatlas_cloud_user_team_assignment.this.invitation_created_at
}

output "invitation_expires_at" {
  value = mongodbatlas_cloud_user_team_assignment.this.invitation_expires_at
}

output "inviter_username" {
  value = mongodbatlas_cloud_user_team_assignment.this.inviter_username
}

output "last_auth" {
  value = mongodbatlas_cloud_user_team_assignment.this.last_auth
}

output "last_name" {
  value = mongodbatlas_cloud_user_team_assignment.this.last_name
}

output "mobile_number" {
  value = mongodbatlas_cloud_user_team_assignment.this.mobile_number
}

output "org_membership_status" {
  value = mongodbatlas_cloud_user_team_assignment.this.org_membership_status
}

output "team_ids" {
  value = mongodbatlas_cloud_user_team_assignment.this.team_ids
}

output "username" {
  value = mongodbatlas_cloud_user_team_assignment.this.username
}
output "roles_org_roles" {
  value = mongodbatlas_cloud_user_team_assignment.this.roles == null ? null : mongodbatlas_cloud_user_team_assignment.this.roles.org_roles
}

output "roles_project_role_assignments" {
  value = mongodbatlas_cloud_user_team_assignment.this.roles == null ? null : mongodbatlas_cloud_user_team_assignment.this.roles.project_role_assignments
}
