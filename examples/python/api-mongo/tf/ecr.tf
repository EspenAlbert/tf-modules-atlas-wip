locals {
  ecr_pull_actions = [
    "ecr:GetAuthorizationToken",
    "ecr:BatchCheckLayerAvailability",
    "ecr:BatchGetImage",
    "ecr:DescribeImageScanFindings",
    "ecr:DescribeImages",
    "ecr:DescribeRepositories",
    "ecr:GetDownloadUrlForLayer",
    "ecr:GetLifecyclePolicy",
    "ecr:GetLifecyclePolicyPreview",
    "ecr:GetRepositoryPolicy",
    "ecr:ListImages",
    "ecr:ListTagsForResource",
  ]
  ecr_push_actions = [
    "ecr:PutImage",
    "ecr:InitiateLayerUpload",
    "ecr:UploadLayerPart",
    "ecr:CompleteLayerUpload",
  ]

}
resource "aws_ecr_repository" "repos" {
  for_each = toset(var.ecr_repos)
  name     = each.value

  image_tag_mutability = "MUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
  }
}

data "aws_caller_identity" "current" {}
data "aws_organizations_organization" "current" {}

data "aws_iam_policy_document" "repoAccess" {
  statement {
    sid    = "AllowPullPushOrganization"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalOrgID"
      values   = [data.aws_organizations_organization.current.id]
    }
    actions = concat(local.ecr_pull_actions, local.ecr_push_actions)
  }
  statement {
    sid    = "AllowPullLambdaOrganization"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "aws:sourceArn"
      values   = ["arn:aws:lambda:${var.aws_region}:${data.aws_caller_identity.current.account_id}:function:*"]
    }
    actions = local.ecr_pull_actions
  }
}

resource "aws_ecr_repository_policy" "this" {
  for_each   = aws_ecr_repository.repos
  policy     = data.aws_iam_policy_document.repoAccess.json
  repository = each.value.name
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each   = aws_ecr_repository.repos
  repository = each.value.name
  policy     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "keep last ten",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
