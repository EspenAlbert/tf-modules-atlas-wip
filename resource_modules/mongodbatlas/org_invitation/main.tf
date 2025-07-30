

resource "mongodbatlas_org_invitation" "this" {
  org_id    = var.org_id
  roles     = var.roles
  teams_ids = var.teams_ids
  username  = var.username
}

