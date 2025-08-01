output "kms_key_id" {
  value = module.cloud_provider_aws.aws_kms_key_id
}

output "aws_iam_role_arn" {
  value = module.cloud_provider_aws.aws_iam_role_arn
}
