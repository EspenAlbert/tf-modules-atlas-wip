module "atlas_project" {
  source           = "../../../../modules/02_project"
  name             = var.atlas_project_name
  org_id           = var.atlas_org_id
  auditing_enabled = false
  tags             = var.tags
  # dev specific
  dev_ips = var.dev_ips
}

module "db_user_admin" {
  source            = "../../../../modules/07_atlas_aws/modules/database_user_iam_role"
  project_id        = module.atlas_project.id
  existing_role_arn = aws_iam_role.app_role.arn
  description       = "Atlas AWS IAM role for database admin"
  labels            = var.tags
  roles = [{
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
  }]
}

module "cluster" {
  source = "../../../../modules/08_cluster_poc"

  name       = var.cluster_name
  project_id = module.atlas_project.id
  regions = [
    {
      name          = "US_EAST_1"
      node_count    = 3
      instance_size = "M10"
      provider_name = "AWS"
    }
  ]
  # dev specific
  backup_enabled         = false
  retain_backups_enabled = false # dev specific
}
