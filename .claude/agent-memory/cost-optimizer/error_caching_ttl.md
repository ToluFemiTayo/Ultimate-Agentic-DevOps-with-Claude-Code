---
name: error_caching_ttl
description: 404 error redirect to index.html has zero TTL, causing repeated origin requests
metadata:
  type: feedback
---

**Finding**: Custom error response for 404s (line 91-96 of main.tf) sets `error_caching_min_ttl = 0`, making the redirect non-cacheable.

**Why**: When error_caching_min_ttl = 0, CloudFront does not cache error responses. For a portfolio site that redirects 404s to /index.html (SPA-like behavior):
- Every 404 request hits S3 origin repeatedly
- No caching means wasted origin capacity and increased data transfer costs
- Should cache the redirect response to avoid redundant S3 requests

**How to apply**: Change `error_caching_min_ttl = 0` to `error_caching_min_ttl = 300` (5 minutes) or higher (e.g., 3600 for 1 hour). For a static portfolio, 300-3600 is reasonable.

**Estimated impact**: MEDIUM — reduces S3 origin requests by 95%+ for 404s. Saves on S3 GET request charges and reduces origin load. For low-traffic sites, ~$0.50-2/month; high-traffic could be more.

**Location**: `terraform/main.tf` line 95
