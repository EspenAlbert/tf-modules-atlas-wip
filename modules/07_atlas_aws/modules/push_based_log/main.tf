resource "aws_s3_bucket" "log_bucket" {
  lifecycle {
    precondition {
      condition     = var.existing_bucket_arn == null && var.bucket_name != null
      error_message = "either existing_bucket_arn or bucket_name must be provided"
    }
  }
  count         = var.existing_bucket_arn == null && var.bucket_name != null ? 1 : 0 # if existing_bucket_arn is provided, we don't need to create a new bucket
  bucket        = var.bucket_name
  force_destroy = true # required for destroying as Atlas may create a test folder in the bucket when push-based log export is set up 
}

locals {
  bucket_arn  = var.existing_bucket_arn != null ? var.existing_bucket_arn : aws_s3_bucket.log_bucket[0].arn
  bucket_name = split("/", local.bucket_arn)[length(split("/", local.bucket_arn)) - 1]
}

# Add authorization policy to existing IAM role
resource "aws_iam_role_policy" "s3_bucket_policy" {
  name = var.bucket_policy_name
  role = var.existing_aws_iam_role_arn

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetBucketLocation"
        ],
        "Resource": [
          "${local.bucket_arn}",
          "${local.bucket_arn}/*"
        ]
      }
    ]
  }
  EOF
}

resource "mongodbatlas_push_based_log_export" "this" {
  project_id  = var.project_id
  bucket_name = local.bucket_name
  iam_role_id = var.mongodb_role_id
  prefix_path = var.prefix_path

  timeouts = var.timeouts
}
