

resource "mongodbatlas_team" "this" {
  name   = var.name
  org_id = var.org_id
}

