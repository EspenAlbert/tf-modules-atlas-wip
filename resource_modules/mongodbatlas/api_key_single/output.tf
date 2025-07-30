output "api_key_id" {
  value = mongodbatlas_api_key.this.api_key_id
}

output "private_key" {
  value = mongodbatlas_api_key.this.private_key
}

output "public_key" {
  value = mongodbatlas_api_key.this.public_key
}
