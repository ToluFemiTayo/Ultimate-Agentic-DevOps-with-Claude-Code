---
name: s3-versioning-without-lifecycle
description: S3 versioning enabled but no lifecycle rule to clean old versions — causes accumulating storage costs
metadata:
  type: project
---

**Finding**: S3 bucket has versioning enabled (`aws_s3_bucket_versioning` status = "Enabled") but no lifecycle rule to expire non-current versions.

**Why**: For a portfolio deployed 2–3x daily, old versions accumulate indefinitely. At $0.023/GB/month in ap-south-1, each deployment's prior version consumes permanent storage. Over 30 days of typical deployments (60–90 versions), storage can balloon 2–5x the current size, costing $10–50/month in storage alone.

**How to apply**: Add `aws_s3_bucket_lifecycle_configuration` resource with a `noncurrent_version_expiration` rule set to 30–90 days. Also add rule to abort incomplete multipart uploads after 7 days.

**Estimated impact**: Medium to High savings ($10–50/month depending on deployment frequency)

**Status**: Identified in terraform/main.tf, needs implementation
