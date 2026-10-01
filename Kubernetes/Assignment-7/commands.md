kubectl config get-contexts
kubectl config set-context --current --namespace=default


kubectl run app --image=nginx --dry-run=client -o yaml > app.yml