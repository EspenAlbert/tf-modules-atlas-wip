output "aws_vpc_endpoint_id" {
  value = local.vpc_endpoint_id
}

output "aws_region" {
  value = local.aws_region
}

output "aws_vpc_cidr_block" {
  value = local.vpc_cidr_block
}

output "atlas_private_endpoint_id" {
  value = mongodbatlas_privatelink_endpoint.mongodb_endpoint
}
