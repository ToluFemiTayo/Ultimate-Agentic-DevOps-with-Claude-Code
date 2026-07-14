---
name: s3_versioning_lifecycle
description: S3 versioning enabled without lifecycle rules causes storage bloat and unnecessary costs
metadata:
  type: feedback
---

**Finding**: S3 bucket has versioning enabled (line 23-29 of main.tf) but no lifecycle rules to manage version retention or object expiration.

**Why**: For a static portfolio website with minimal file changes, versioning without lifecycle policies is expensive:
- Every updated file creates a new version, keeping old versions indefinitely
- Portfolio sites rarely need complete version history
- Storage costs accumulate as versions pile up without automatic cleanup
- Each version counts toward storage quota and incurs retrieval/storage charges

**How to apply**: 
1. Either disable versioning entirely (simple case for portfolio site)
2. OR add S3 lifecycle rules to:
   - Delete non-current versions after 30 days
   - Transition non-current versions to Glacier for archival if compliance requires
   - Set Intelligent-Tiering for infrequent access patterns

**Estimated impact**: HIGH — can reduce storage costs by 50-90% depending on update frequency and versioning retention strategy.

**Location**: `terraform/main.tf` lines 23-29
