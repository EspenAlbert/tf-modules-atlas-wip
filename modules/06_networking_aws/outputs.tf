output "aws_vpc_endpoint_id" {
  value = local.use_aws_private_endpoint ? aws_vpc_endpoint.aws_endpoint[0].id : null
}

output "aws_region" {
  value = local.aws_region
}
