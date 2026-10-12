21. Terraform Module Registry
Create resuable module:
- EC2
- SGs
- EBS

Publish Internally

NOTES
- Three reusable modules live in `modules/`: `ec2`, `sg` and `ebs`. The root `main.tf` wires them together.
- Left side of an argument in a `module` block must match a variable declared in that child module's `variables.tf`; the right side (`var.x`) must be declared in the root `variables.tf`, or be another module's output (`module.x.output`).
- Values passed between modules (`module.sg.security_group_id`, `module.ebs.ebs_volume_id`) need no root variable, only a child output and a child variable.
- `vpc_security_group_ids` is the provider's argument name (expects a list); `security_group_id` is our own module variable.
- No `vpc_id`/`subnet_id` is set, so the SG and instance use the region's default VPC. Needs a default VPC to exist.
- The EC2 instance and EBS volume must share the same `availability_zone`, otherwise the attachment fails.
- "Publish internally" normally means a private module registry (e.g. HCP Terraform). For practice, local paths (`./modules/...`) are enough.
- Optional versioning: push to GitHub, tag a release and reference it, e.g. `source = "git::https://github.com/<user>/<repo>.git//path/modules/ec2?ref=v1.0.0"`. A `ref` can be a branch, tag or commit; tags are best for versions.