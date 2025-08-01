
output "kms_key_id" {
  value = aws_kms_key.this.id
}

output "aws_iam_role_arn" {
  value = aws_iam_role.this.arn
}
