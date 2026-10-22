# Terraform notes

This folder is a starter example, not a complete EKS cluster deployment. It creates a VPC, public/private subnets, NAT gateway, and ECR repository. EKS cluster and node groups should be added using a reviewed module with explicit IAM, endpoint access, encryption, logging, upgrades, and capacity configuration.

## Remote state bootstrap

Create a dedicated S3 bucket separately before using it as the backend. Enable versioning, block public access, default encryption, least-privilege access, and optionally Object Lock according to your recovery policy. Backend configuration cannot create its own backend bucket during `terraform init`.

Then configure `backend.tf` with your unique bucket name and key. State can contain sensitive values; do not commit it.

## Commands

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform destroy # only after carefully reviewing the plan
```

Use an AWS profile or role, for example `aws sso login --profile dev` and `export AWS_PROFILE=dev`. Never put access keys in `.tf` files.
