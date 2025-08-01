
locals {
  subnet_count = 3
  azs          = slice(data.aws_availability_zones.available.names, 0, local.subnet_count)
  aws_region   = replace(lower(var.atlas_region), "_", "-")

}
provider "aws" {
  region = local.aws_region
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
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, local.subnet_count, k)]

  tags = merge({
    Name = var.vpc_name
  }, local.tags)

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
