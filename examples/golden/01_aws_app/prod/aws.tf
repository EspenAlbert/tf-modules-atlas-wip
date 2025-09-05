
locals {
  subnet_count = 3
  subnet_bits  = 3 # 2^3 = 8 subnets, in case more needs to be added
  azs          = slice(data.aws_availability_zones.available.names, 0, local.subnet_count)
  aws_region   = replace(lower(var.atlas_region), "_", "-")

}
provider "aws" {
  region = local.aws_region
  default_tags {
    tags = var.tags
  }
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name                          = var.vpc_name
  cidr                          = var.vpc_cidr
  manage_default_security_group = false
  manage_default_network_acl    = false

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, local.subnet_bits, k)]

  tags = merge(var.tags, {
    Name = var.vpc_name
  })

}

resource "aws_security_group" "this" {
  name_prefix = "default-ingress-"
  description = "Default security group for all instances in vpc"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = [
      module.vpc.vpc_cidr_block
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "aws_caller_identity" "current" {}


resource "aws_kms_key" "this" {
  description = "MongoDB Atlas KMS key."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "key-default-1",
    "Statement" : [
      {
        "Sid" : "Allow administration of the key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : [
          "kms:*"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key by specific IAM user",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : module.atlas_aws.aws_iam_role_arn
        },
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:DescribeKey"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "aws:PrincipalArn" : module.atlas_aws.aws_iam_role_arn
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "app_role" {

  lifecycle {
    precondition {
      condition     = var.aws_iam_role_app_name != null
      error_message = "aws_iam_role_name must be set when existing_aws_iam_role_arn is null"
    }
  }
  name = var.aws_iam_role_app_name

  # TODO: Update the assume role policy to support a lambda or similar to assume the role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS":  "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
