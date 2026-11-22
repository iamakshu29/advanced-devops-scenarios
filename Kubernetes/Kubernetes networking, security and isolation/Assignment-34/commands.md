# Create Secret -
`kubectl create secret generic my-secret --from-literal=DB_USERNAME=mysql --from-literal=DB_PASSWORD=supersecretstring --dry-run=client -o yaml > secret.yml`

# Create Secret from AWS Secrets Manager Values -
`kubectl create secret generic my-secret --from-literal=DB_USERNAME="$DB_USERNAME" --from-literal=DB_PASSWORD="$DB_PASSWORD" --dry-run=client -o yaml > secret_from_aws.yml`

# Create Role -
`kubectl create role dev-role --dry-run=client --verb=get,list,watch --resource=secrets,pods  -o yaml > dev_role.yml `

# Create RoleBinding -
`kubectl create rolebinding dev-rolebinding --role=dev-role --dry-run=client --serviceaccount=default:dev-sa -o yaml > dev-rolebinding.yml`

# Create ServiceAccount -
`kubectl create serviceaccount dev-sa --dry-run=client -o yaml > dev-sa.yml`

# Create ServiceAccount -
`kubectl create serviceaccount unauthorized-sa --dry-run=client -o yaml > unauthorized-sa.yml`
