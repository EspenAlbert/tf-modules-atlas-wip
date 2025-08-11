module "cloud_provider_aws" {
  source = "../../../modules/04_cloud_provider_aws"

  project_id   = module.atlas_project.id
  atlas_region = var.atlas_region
  aws_encryption_at_rest = {
    enabled                    = true
    require_private_networking = true
  }
  aws_iam_role_name = var.aws_iam_role_name
}
