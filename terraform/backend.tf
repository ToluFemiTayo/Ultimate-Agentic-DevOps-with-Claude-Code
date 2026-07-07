# S3 backend configuration for Terraform state
#
# IMPORTANT: Follow these steps to use the S3 backend:
#
# 1. First run: `terraform init`
#    This initializes Terraform with local state
#
# 2. Run: `terraform apply`
#    This creates the S3 bucket and CloudFront resources
#
# 3. Create an S3 bucket for Terraform state (if not already created)
#    You can do this manually via AWS Console or with Terraform
#
# 4. Uncomment the terraform block below and update the bucket name
#
# 5. Run: `terraform init -migrate-state`
#    This will prompt you to migrate the existing local state to the S3 backend
#
# After these steps, your Terraform state will be stored remotely in S3

/*
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "portfolio-site/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
*/
