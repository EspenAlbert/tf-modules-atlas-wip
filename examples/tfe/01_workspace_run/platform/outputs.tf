output "aws_vpc_endpoint_id" {
  value = try(aws_vpc_endpoint.aws_endpoint[0].id, "")
}
