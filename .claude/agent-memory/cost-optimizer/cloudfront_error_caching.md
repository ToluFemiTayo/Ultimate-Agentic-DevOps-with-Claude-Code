---
name: cloudfront-error-caching-disabled
description: 404→/index.html error response never cached, causing repeated origin requests
metadata:
  type: project
---

**Finding**: CloudFront custom error response (lines 91–96 in terraform/main.tf) redirects 404 errors to /index.html with `error_caching_min_ttl = 0`.

**Why**: Setting `error_caching_min_ttl = 0` prevents CloudFront from caching the error response. This is common in SPA deployments where non-existent paths legitimately serve /index.html. However, every request to non-existent paths (typos, crawlers, old links) causes an origin request rather than being served from cache, increasing origin load and transfer costs.

**Recommended**: Set `error_caching_min_ttl = 300` (5 minutes) to 3600 (1 hour). This caches the 404→/index.html redirect, reducing origin requests by 95%.

**How to apply**: Change lines 91–96 in terraform/main.tf:
```hcl
custom_error_response {
  error_code            = 404
  response_code         = 200
  response_page_path    = "/index.html"
  error_caching_min_ttl = 300  # Changed from 0
}
```

**Estimated impact**: Low savings ($0–5/month), but reduces origin load and potential 403/5xx errors during traffic spikes

**Status**: Ready to implement — safe change, commonly used in SPA deployments
