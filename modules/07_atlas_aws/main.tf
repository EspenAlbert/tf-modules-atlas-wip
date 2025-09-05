locals {
  has_existing_aws_iam_role = var.existing_aws_iam_role.enabled
  aws_iam_role_arn          = local.has_existing_aws_iam_role ? var.existing_aws_iam_role.arn : aws_iam_role.this[0].arn
}

# tflint-ignore: terraform_unused_declarations
data "aws_iam_role" "this" {
  count = local.has_existing_aws_iam_role ? 1 : 0

  lifecycle {
    postcondition {
      condition     = var.existing_aws_iam_role.arn == self.arn
      error_message = "value of existing_aws_iam_role_arn does not match the actual IAM role ARN"
    }
  }
  name = split("/", var.existing_aws_iam_role.arn)[length(split("/", var.existing_aws_iam_role.arn)) - 1]
}

resource "mongodbatlas_cloud_provider_access_setup" "this" {
  project_id    = var.project_id
  provider_name = "AWS"
}

resource "mongodbatlas_cloud_provider_access_authorization" "this" {
  project_id = var.project_id
  role_id    = mongodbatlas_cloud_provider_access_setup.this.role_id

  aws {
    iam_assumed_role_arn = local.aws_iam_role_arn
  }
}

module "encryption_at_rest" {
  source = "./modules/encryption_at_rest"
  count  = var.encryption_at_rest.enabled ? 1 : 0

  project_id                 = var.project_id
  atlas_region               = var.atlas_region
  aws_kms_key_id             = var.encryption_at_rest.aws_kms_key_id
  enabled_for_search_nodes   = var.encryption_at_rest.enabled_for_search_nodes
  enable_private_endpoint    = var.encryption_at_rest.enable_private_endpoint
  existing_aws_iam_role_arn  = local.aws_iam_role_arn
  atlas_role_id              = mongodbatlas_cloud_provider_access_authorization.this.role_id
  require_private_networking = var.encryption_at_rest.require_private_networking

  # Adding an explicit dependency for the authorization to ensure the role_id has been authorized
  # Since the role_id from the authorization comes from setup resource Terraform doesn't infer this by default
  depends_on = [mongodbatlas_cloud_provider_access_authorization.this]
}

module "push_based_log_export" {
  source = "./modules/push_based_log"
  count  = var.push_based_log_export.enabled ? 1 : 0

  project_id                = var.project_id
  existing_aws_iam_role_arn = local.aws_iam_role_arn
  existing_bucket_arn       = var.push_based_log_export.existing_bucket_arn
  atlas_role_id             = mongodbatlas_cloud_provider_access_authorization.this.role_id
  prefix_path               = var.push_based_log_export.prefix_path
  bucket_name               = var.push_based_log_export.bucket_name
  create_s3_bucket          = var.push_based_log_export.create_s3_bucket
  bucket_policy_name        = var.push_based_log_export.bucket_policy_name
  timeouts                  = var.push_based_log_export.timeouts

  # Adding an explicit dependency for the authorization to ensure the role_id has been authorized
  # Since the role_id from the authorization comes from setup resource Terraform doesn't infer this by default
  depends_on = [mongodbatlas_cloud_provider_access_authorization.this]
}

module "privatelink_with_existing_vpc_endpoint" {
  source = "./modules/privatelink"
  count  = var.privatelink_with_existing_vpc_endpoint.enabled ? 1 : 0

  project_id                        = var.project_id
  existing_vpc_endpoint_id          = var.privatelink_with_existing_vpc_endpoint.existing_vpc_endpoint_id
  add_vpc_cidr_block_project_access = var.privatelink_with_existing_vpc_endpoint.add_vpc_cidr_block_project_access
  atlas_region                      = var.atlas_region
}

module "privatelink_with_managed_vpc_endpoint" {
  source = "./modules/privatelink"
  count  = var.privatelink_with_managed_vpc_endpoint.enabled ? 1 : 0

  project_id = var.project_id
  aws_private_endpoint = {
    security_group_ids = var.privatelink_with_managed_vpc_endpoint.security_group_ids
    subnet_ids         = var.privatelink_with_managed_vpc_endpoint.subnet_ids
    vpc_id             = var.privatelink_with_managed_vpc_endpoint.vpc_id
  }
  add_vpc_cidr_block_project_access = var.privatelink_with_managed_vpc_endpoint.add_vpc_cidr_block_project_access
  aws_tags                          = var.privatelink_with_managed_vpc_endpoint.tags
  atlas_region                      = var.atlas_region
}

module "database_user_iam_role" {
  source = "./modules/database_user_iam_role"
  count  = var.aws_iam_role_db_admin.enabled ? 1 : 0

  project_id        = var.project_id
  existing_role_arn = var.aws_iam_role_db_admin.role_arn
  description       = var.aws_iam_role_db_admin.description
  labels            = var.aws_iam_role_db_admin.labels
  roles = [{
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
    },
    {
      role_name     = "atlasAdmin"
      database_name = "admin"
  }]
}
