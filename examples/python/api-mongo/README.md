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
