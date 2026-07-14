---
name: feedback-audit-scope
description: How to scope and report Terraform security findings for this repo
metadata:
  type: feedback
---

When auditing `terraform/` in this repo, only report on checklist items that have corresponding resources in the code — explicitly note when a category (e.g. IAM least privilege, OIDC trust policy scoping) has no resources to review rather than inventing hypothetical findings. This repo is a simple static-site (S3+CloudFront) stack with no IAM/OIDC resources as of 2026-07-13 (see [[project-terraform-layout]]).

**Why**: The checklist given to the security-auditor agent is broad (covers IAM, OIDC, CloudFront, S3, encryption, headers) but this specific repo's infra is narrow. Padding a report with "N/A" boilerplate or fabricated risk for nonexistent resources reduces signal; a clear "not applicable" callout is more useful than silence or invented findings.

**How to apply**: After reading all `.tf` files, first identify which checklist categories have zero matching resources, group those under a short "Not applicable" section at the end, and spend the actual prioritized findings effort only on resources that exist in the code.
