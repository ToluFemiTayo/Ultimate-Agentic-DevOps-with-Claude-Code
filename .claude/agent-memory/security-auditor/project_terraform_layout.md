---
name: project-terraform-layout
description: Structure and current state of terraform/ for the portfolio site (S3+CloudFront), as of the 2026-07-13 audit
metadata:
  type: project
---

The `terraform/` directory provisions a static portfolio site on S3 + CloudFront (per root CLAUDE.md, this repo is the HTML/CSS portfolio deployed via Terraform + GitHub Actions). Files: `providers.tf`, `variables.tf`, `outputs.tf`, `main.tf`, `backend.tf`. No IAM, OIDC, or GitHub Actions workflow files exist yet in this repo (as of 2026-07-13) — so IAM/OIDC checklist items are not applicable until those are added.

**Why**: Useful to know when auditing so time isn't spent looking for IAM/OIDC files that don't exist, and so future audits can diff against this known-good baseline of what's already correctly configured vs. what's missing.

**Already correct in this repo's `main.tf` (as of 2026-07-13)**:
- S3 public access block fully enabled (all 4 flags true).
- CloudFront uses OAC (not OAI), bucket policy scoped with `AWS:SourceArn` condition.
- `viewer_protocol_policy = "redirect-to-https"`.
- S3 versioning enabled.
- Account ID sourced via `data.aws_caller_identity.current`, never hardcoded.
- `.gitignore` at repo root correctly excludes `*.tfstate` and `.terraform/`.

**Recurring gaps found in this repo (check if still present on next audit)**:
- No `aws_s3_bucket_server_side_encryption_configuration` (missing SSE at rest).
- No `response_headers_policy_id` on CloudFront default_cache_behavior (missing CSP/X-Frame-Options/HSTS/etc).
- No CloudFront `logging_config` and no `aws_s3_bucket_logging` (no access logs at all).
- `backend.tf` has the S3 backend block commented out with bootstrap instructions — state is local by default; intentional bootstrap pattern but should be verified as enabled once the state bucket exists.
- No lifecycle rule to expire noncurrent S3 object versions despite versioning being enabled.
- `variables.tf` defines `domain_name` but it is never referenced in `main.tf` — dead variable; CloudFront uses `cloudfront_default_certificate = true` only.
- No WAF attached to the CloudFront distribution (low priority for a static portfolio site).

See [[feedback-audit-scope]] for how findings should be scoped/reported for this project.
