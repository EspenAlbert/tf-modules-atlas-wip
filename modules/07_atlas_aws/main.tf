locals {
  has_existing_aws_iam_role = var.existing_aws_iam_role.enabled
  aws_iam_role_arn          = local.has_existing_aws_iam_role ? var.existing_aws_iam_role.arn : aws_iam_role.this[0].arn
}

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

module "push_based_log_export" {
  source = "./modules/push_based_log"
  count  = var.push_based_log_export.enabled ? 1 : 0

  project_id                = var.project_id
  existing_aws_iam_role_arn = local.aws_iam_role_arn
  mongodb_role_id           = mongodbatlas_cloud_provider_access_authorization.this.role_id
  prefix_path               = var.push_based_log_export.prefix_path
  bucket_name               = var.push_based_log_export.bucket_name
  bucket_policy_name        = var.push_based_log_export.bucket_policy_name
  timeouts                  = var.push_based_log_export.timeouts
}

module "privatelink_with_existing_vpc_endpoint" {
  source = "./modules/privatelink"
  count  = var.privatelink_with_existing_vpc_endpoint.enabled ? 1 : 0

  project_id                        = var.project_id
  existing_vpc_endpoint_id          = var.privatelink_with_existing_vpc_endpoint.existing_vpc_endpoint_id
  add_vpc_cidr_block_project_access = var.privatelink_with_existing_vpc_endpoint.add_vpc_cidr_block_project_access
  atlas_region                      = var.atlas_region
}
