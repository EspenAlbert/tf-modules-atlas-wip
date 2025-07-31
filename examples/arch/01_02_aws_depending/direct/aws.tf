
data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role" "this" {
  name = var.aws_iam_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${mongodbatlas_cloud_provider_access_setup.this.aws_config[0].atlas_aws_account_arn}"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${mongodbatlas_cloud_provider_access_setup.this.aws_config[0].atlas_assumed_role_external_id}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_kms_key" "this" {
  description             = "KMS key for atlas LZ Modules"
  deletion_window_in_days = 7
  multi_region            = true
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
      Sid    = "Enable IAM User Permissions Current AWS Account",
      Effect = "Allow",
      Principal = {
        AWS = local.aws_account_id
      },
      Action   = "kms:*",
      Resource = "*"
    },
      {
        Sid    = "Enable IAM Permissions for Atlas AWS IAM Role ${var.aws_iam_role_name}"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "kms:Decrypt"
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalArn" = aws_iam_role.this.arn
          }
        }
      }
    ]
  })
}

output "kms_key_id" {
  value = aws_kms_key.this.id
}
