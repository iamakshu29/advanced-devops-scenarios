```bash
# deploy
kubectl create deploy example-deploy --replicas=1 --image=nginx:latest --dry-run=client -o yaml > deploy.yml

# service
kubectl create service clusterip example-svc --tcp=80:80 --dry-run=client -o yaml > service.yml

# Roles
kubectl create role reader-role --verb=get,list,watch --resource=deployments,pods,services,configmap --dry-run=client -o yaml > reader-role.yml
kubectl create role developer-role --verb=get,list,watch,create,delete,update,patch --resource=deployments,pods,services,configmap --dry-run=client -o yaml > developer-role.yml
kubectl create role admin-role --verb='*' --resource='*.*' --dry-run=client -o yaml > admin-role.yml

#ServiceAccount
kubectl create sa sa-read --dry-run=client -o yaml > reader-sa.yml
kubectl create sa sa-dev --dry-run=client -o yaml > developer-sa.yml
kubectl create sa sa-admin --dry-run=client -o yaml > admin-sa.yml

# RoleBinding
kubectl create rolebinding reader-binding --role=reader-role --serviceaccount=default:sa-read --dry-run=client -o yaml > reader-rb.yml
kubectl create rolebinding developer-binding --role=developer-role --serviceaccount=default:sa-dev --dry-run=client -o yaml > developer-rb.yml
kubectl create rolebinding admin-binding --role=admin-role --serviceaccount=default:sa-admin --dry-run=client -o yaml > admin-rb.yml
```