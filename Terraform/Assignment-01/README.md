1. Multi Environment Terraform Architecture
Scenario
Design reuable terraform code to deploy separate Environment (dev, staging, prod).

Requirements
- Use Modules
- Separate State files per Environment
- Use remote backend (s3 + locking)
- Use workspace or folder based strategy
- Implement Tagging strategy
- Implement env-specific variables