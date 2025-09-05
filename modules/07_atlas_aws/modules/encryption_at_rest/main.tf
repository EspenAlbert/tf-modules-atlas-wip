locals {
  role_name = split("/", var.existing_aws_iam_role_arn)[length(split("/", var.existing_aws_iam_role_arn)) - 1]
}

resource "aws_iam_role_policy" "encryption_at_rest_policy" {
  name = var.aws_iam_role_policy_name
  role = local.role_name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:DescribeKey"
        ],
        "Resource" : [
          var.aws_kms_key_id
        ]
      }
    ]
  })
}

resource "mongodbatlas_encryption_at_rest" "this" {
  lifecycle {
    postcondition {
      condition     = self.aws_kms_config[0].valid
      error_message = "AWS KMS config is not valid"
    }
  }
  project_id = var.project_id
  aws_kms_config {
    enabled                    = true
    customer_master_key_id     = var.aws_kms_key_id
    region                     = var.atlas_region
    role_id                    = var.atlas_role_id
    require_private_networking = var.require_private_networking
  }
  enabled_for_search_nodes = var.enabled_for_search_nodes
}

resource "mongodbatlas_encryption_at_rest_private_endpoint" "this" {
  count = var.enable_private_endpoint ? 1 : 0

  project_id     = mongodbatlas_encryption_at_rest.this.project_id
  cloud_provider = "AWS"
  region_name    = var.atlas_region
}
