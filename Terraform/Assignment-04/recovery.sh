#!/bin/bash

# Initialize Terraform:
# - -input=false prevents interactive prompts in case of Backend configuration changes
terraform init -input=false

# - -input=false prevents Terraform from waiting for user input
# - -detailed-exitcode returns:
#     0 = No changes detected
#     1 = Error occurred
#     2 = Changes detected
# - -out saves the generated plan into a file (tfplan)
terraform plan \
  -input=false \
  -detailed-exitcode \
  -out=tfplan

# Capture Terraform plan's exit code immediately
EXIT_CODE=$?

# Evaluate the exit code
if [ "$EXIT_CODE" -eq 0 ]; then

    echo "Infrastructure is up to date."
    echo "No infrastructure changes are required"

elif [ "$EXIT_CODE" -eq 2 ]; then

    echo "Infrastructure changes or drift detected"
    echo "Trigger notification (Slack, Teams, Email, etc.)"
    echo "Manual Approval Step Ahead. Before Applying the Changes"

else

    # Exit code 1 indicates a planning error
    # This could be caused by state issues, configuration errors,
    # authentication problems, backend issues, etc.
    echo "Terraform plan failed!"
    echo "Manual investigation required."
    echo "Check for Changes"
    echo "Import or Restore from the Older Stable version from S3 and run plan again in case of Corrupted State File"
    echo "Check for AWS authentication issue, invalid configuration, provider error, backend connectivity issue, etc."
    exit 1

fi
