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


## Terraform workspaces

- **tf_ecr**: Provisions the ECR repository that stores the Lambda image.
  - Inputs: `AWS_REGION`, `ECR_REPOSITORY_NAME` (defaults to `api-mongo-python`).
  - Usage: `cd tf_ecr && terraform init && terraform apply`.

- **tf_lambda**: Provisions the Lambda function, VPC config, and IAM wiring.
  - Inputs: `AWS_ACCOUNT_ID`, `AWS_REGION`, `ECR_REPOSITORY_NAME` (defaults as above), `VPC_ID`, `VPC_SUBNET_IDS` (comma-separated), `MONGO_URL`, `LAMBDA_EXECUTION_ROLE_ARN`, `IMAGE_TAG`.
  - Usage: `cd tf_lambda && terraform init && terraform apply`.

## Key just commands

- **run-local**: Run the API locally with Uvicorn (uses `MONGO_URL`).
- **build-lambda**: Build the Lambda container image locally.
- **aws-ecr-login**: Authenticate Docker to your AWS ECR registry.
- **push-lambda TAG**: Build (via dependency) and push the image to ECR with tag `TAG`. Uses `ECR_REPOSITORY_NAME` (defaults to `api-mongo-python`).
- **tf-vars-auto-ecr**: Generate `tf_ecr/terraform.auto.tfvars.json` from environment variables.
- **tf-vars-auto-lambda TAG**: Generate `tf_lambda/terraform.auto.tfvars.json` using env vars and image `TAG`.
