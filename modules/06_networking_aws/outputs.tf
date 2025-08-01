output "aws_vpc_endpoint_id" {
  value = try(one(aws_vpc_endpoint.aws_endpoint).id, null)
}

output "aws_region" {
  value = local.aws_region
}


output "aws_vpc_cidr_block" {
  value = try(data.aws_vpc.this[0].cidr_block, null)
}

output "atlas_private_endpoint_id" {
  value = try(one(mongodbatlas_privatelink_endpoint.mongodb_endpoint).id, null)
}
