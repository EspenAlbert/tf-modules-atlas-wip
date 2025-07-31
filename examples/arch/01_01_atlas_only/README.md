# Example from [architecture center](https://github.com/mongodb/docs-atlas-architecture/blob/main/source/includes/examples/tf-example-complete-staging-prod.tf)

- This module maps all the attributes of [`mongodbatlas_advanced_cluster (preview provider 2.0.0)`](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster%2520%2528preview%2520provider%25202.0.0%2529%2520%2528preview%2520provider%25202.0.0%2529) to [variables.tf](variables.tf).
- Remember to set the `export MONGODB_ATLAS_ADVANCED_CLUSTER_V2_SCHEMA=true` in your terminal before running `terraform` commands.

## How to Run
```sh
cd modules
terraform init
terraform apply -var-file ../example.tfvars -var atlas_org_id={YOUR_ORG_ID}
```
