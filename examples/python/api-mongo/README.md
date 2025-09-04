# Minimal example API for Checking a Mongo URL Connection

## Lambda Build & Push
```sh
export AWS_ACCOUNT_ID="ACCOUNT_ID" # update me
export AWS_REGION="us-east-1"
export ECR_REPOSITORY_NAME="api-mongo-python"
export TAG="0.0.1" # update to bump

# Build and tag for ECR
docker build -f Dockerfile_lambda -t ${ECR_REPOSITORY_NAME}:latest .
docker tag ${ECR_REPOSITORY_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${TAG}

# Push to ECR
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${TAG}
```

## Example Terraform Usage

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.22.0"
    }
  }
  required_version = "~> 1.5"
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" { type = string }
variable "ecr_repos"  { type = list(string) }
variable "image_uri"  { type = string }
variable "vpc_id"     { type = string }
variable "vpc_subnet_ids" { type = list(string) }
variable "env_vars" {
  type      = map(string)
  default   = {}
  sensitive = true
}

module "api_mongo" {
  source = "./tf"

  aws_region     = var.aws_region
  ecr_repos      = ["example-repo"]
  image_uri      = var.image_uri # e.g. "000000000000.dkr.ecr.us-east-1.amazonaws.com/example-repo:0.0.1"
  vpc_id         = var.vpc_id
  vpc_subnet_ids = var.vpc_subnet_ids

  env_vars = {
    # Example of a url with credentials
    MONGO_URL = "mongodb+srv://user:pass@cluster.example.mongodb.net/?retryWrites=true&w=majority"
    # Example of Privatelink
    MONGO_URL = "mongodb://pl-0-us-east-1.1osuf4.mongodb-dev.net:1024,pl-0-us-east-1.1osuf4.mongodb-dev.net:1025,pl-0-us-east-1.1osuf4.mongodb-dev.net:1026/?ssl=true&authSource=admin&replicaSet=atlas-a7ohzc-shard-0"
  }
}

output "lambda_url" {
  value = module.api_mongo.lambda_url
}
```
