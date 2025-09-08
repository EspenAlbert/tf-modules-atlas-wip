

resource "mongodbatlas_team" "this" {
  name   = var.mongodbatlas_team.name
  org_id = var.mongodbatlas_team.org_id
}

