output "aws_vpc_endpoint_id" {
  value = module.networking_aws.aws_vpc_endpoint_id
}

output "aws_vpc_id" {
  value = module.vpc.vpc_id
}

output "security_group_id" {
  value = aws_security_group.this.id
}

output "aws_region" {
  value = local.aws_region
}
