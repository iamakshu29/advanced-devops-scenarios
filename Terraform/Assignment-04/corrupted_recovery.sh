#!/bin/bash

set -e

echo "List versions of the state file"
aws s3api list-object-versions \
  --bucket <bucket_name> \
  --prefix terraform/dev/terraform.tfstate

echo "Download a specific version"
aws s3api get-object \
  --bucket <bucket_name> \
  --key terraform/dev/terraform.tfstate \
  --version-id "VERSION_ID" \
  terraform.tfstate

echo "Verify the downloaded state"
terraform state list -state=terraform.tfstate

echo "Checking JSON validity"
jq empty terraform.tfstate

echo "Restore the previous version by copying that version onto the current object"
aws s3api copy-object \
  --bucket my-terraform-state-bucket \
  --copy-source 'my-terraform-state-bucket/terraform/dev/terraform.tfstate?versionId=VERSION_ID' \
  --key terraform/dev/terraform.tfstate