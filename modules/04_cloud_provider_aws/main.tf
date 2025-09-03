locals {
  aws_iam_role_arn       = var.existing_aws_iam_role_arn != null ? var.existing_aws_iam_role_arn : aws_iam_role.this[0].arn
  use_encryption_at_rest = var.aws_encryption_at_rest.enabled
  create_kms_key         = var.aws_encryption_at_rest.enabled && var.aws_encryption_at_rest.customer_master_key_id == null
  kms_key_id             = try(local.create_kms_key ? aws_kms_key.this[0].id : var.aws_encryption_at_rest.customer_master_key_id, null)
}

# tflint-ignore: terraform_unused_declarations
data "aws_iam_role" "this" {
  count = var.existing_aws_iam_role_arn != null ? 1 : 0

  lifecycle {
    postcondition {
      condition     = var.existing_aws_iam_role_arn == self.arn
      error_message = "value of existing_aws_iam_role_arn does not match the actual IAM role ARN"
    }
  }
  name = split("/", var.existing_aws_iam_role_arn)[length(split("/", var.existing_aws_iam_role_arn)) - 1]
}

resource "mongodbatlas_cloud_provider_access_setup" "this" {
  project_id    = var.project_id
  provider_name = "AWS"
}

# AWS ONLY- remove for other cloud providers: Enable BYOK encryption
# For IAM roles and Azure assigned identities, you must create the 
# role or identity and declare the variable before you use this 
# Terraform resource
resource "mongodbatlas_cloud_provider_access_authorization" "this" {
  project_id = var.project_id
  role_id    = mongodbatlas_cloud_provider_access_setup.this.role_id

  aws {
    iam_assumed_role_arn = local.aws_iam_role_arn
  }
}
