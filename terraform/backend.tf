# S3 backend for Terraform state management
#
# Instructions for first-time setup:
# 1. Initially, run `terraform init` WITHOUT uncommenting the backend block below.
#    This will use local state.
#
# 2. Run `terraform apply` to create the resources defined in this configuration.
#
# 3. After the initial apply succeeds, uncomment the backend block below.
#
# 4. Run `terraform init -migrate-state` to migrate the local state to S3.
#    When prompted, confirm the migration.
#
# 5. Verify the state has been migrated to S3:
#    - Check your S3 bucket for the terraform.tfstate file
#    - Verify your local .terraform directory reflects the new backend
#
# Note: Ensure the S3 bucket and DynamoDB table exist before uncommenting the backend.
#

# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
