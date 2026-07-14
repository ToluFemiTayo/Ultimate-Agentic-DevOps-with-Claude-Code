---
name: cloudfront-price-class-overspend
description: CloudFront PriceClass_200 includes expensive edge locations not needed for portfolio site
metadata:
  type: project
---

**Finding**: CloudFront distribution configured with `price_class = "PriceClass_200"` (line 76 in terraform/main.tf).

**Coverage breakdown:**
- PriceClass_100: North America, Europe, Asia (~50% of edge locations, cheapest)
- PriceClass_200: All above + Middle East, Africa (~95% of edge locations, 25% more expensive)
- PriceClass_All: All edge locations globally (most expensive)

**Why**: A static portfolio site serving primarily to North America, Europe, and Asia audiences incurs unnecessary edge location costs by including Middle East and Africa. PriceClass_100 reduces data transfer costs ~25% with negligible user-experience impact.

**How to apply**: Change line 76 from `price_class = "PriceClass_200"` to `price_class = "PriceClass_100"`. Requires `terraform plan` and `terraform apply`. Safe change, no downtime.

**Estimated impact**: Medium savings ($5–25/month depending on traffic volume)

**Status**: Ready to implement — low effort, high confidence
