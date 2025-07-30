

resource "mongodbatlas_org_invitation" "this" {
  org_id    = var.mongodbatlas_org_invitation.org_id
  roles     = var.mongodbatlas_org_invitation.roles
  teams_ids = var.mongodbatlas_org_invitation.teams_ids
  username  = var.mongodbatlas_org_invitation.username
}

