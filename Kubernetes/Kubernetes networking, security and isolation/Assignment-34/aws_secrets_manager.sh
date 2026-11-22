#!/bin/sh

# {
#   "DB_USERNAME": "mysql",
#   "DB_PASSWORD": "supersecretstring"
# }

echo "Retrieving the DB_USERNAME from DB_SECRET from AWS Secrets Manager"
DB_USERNAME=$(aws secretsmanager get-secret-value \
  --secret-id DB_SECRET \
  --region us-east-1 \
  --query SecretString \
  --output text | jq -r '.DB_USERNAME')

if [ -z "$DB_USERNAME" ]; then
    echo "Variable is empty or unset"
    echo "Adding the value manually"
    DB_USERNAME=${DB_USERNAME:-mysql}
fi
echo "Variable has a value: $DB_USERNAME"



echo "Retrieving the DB_USERNAME from DB_SECRET from AWS Secrets Manager"
DB_PASSWORD=$(aws secretsmanager get-secret-value \
  --secret-id DB_SECRET \
  --region us-east-1 \
  --query SecretString \
  --output text | jq -r '.DB_PASSWORD')

if [ -z "$DB_PASSWORD" ]; then
    echo "Variable is empty or unset"
    echo "Adding the value manually"
    DB_PASSWORD=${DB_PASSWORD:-supersecretstring}
fi
echo "Variable has a value: $DB_PASSWORD"

echo "Creating the Secrets from the retrieved values"
kubectl create secret generic my-secret --from-literal=DB_USERNAME="$DB_USERNAME" --from-literal=DB_PASSWORD="$DB_PASSWORD" --dry-run=client -o yaml > secret_from_aws.yml