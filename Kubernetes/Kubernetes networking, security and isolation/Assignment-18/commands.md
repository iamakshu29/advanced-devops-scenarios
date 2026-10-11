```bash
kubectl create deploy frontend --replicas=1 --image=nginx:latest --dry-run=client -o yaml > frontend.yml
kubectl create deploy backend --replicas=1 --image=nginx:latest --dry-run=client -o yaml > backend.yml
kubectl create deploy database --replicas=1 --image=nginx:latest --dry-run=client -o yaml > database.yml

kubectl create service clusterip frontend-svc --tcp=80:80 --dry-run=client -o yaml > frontend-svc.yml
kubectl create service clusterip backend-svc --tcp=80:80 --dry-run=client -o yaml > backend-svc.yml
kubectl create service clusterip database-svc --tcp=80:80 --dry-run=client -o yaml > database-svc.yml

kubectl create configmap nginx-configmap \
--from-file=frontend=./frontend/index.html \
--from-file=backend=./backend/index.html \
--from-file=database=./database/index.html --dry-run=client -o yaml > nginx-index-cmap.yml

# To test frontend from test-pod
kubectl run test-pod --image=curlimages/curl --rm -i --restart=Never -- curl -s frontend-svc

# To test backend from frontend
kubectl exec -it frontend-c49b44769-sdwcg -- curl backend-svc

# To test database from backend
kubectl exec -it database-c49b44769-sdwcg -- curl database-svc
```