```bash
kubectl create deploy old-version-deploy --replicas=3 --image=nginx:1.25.1 --dry-run=client -o yaml > blue.yml

kubectl create deploy new-version-deploy --replicas=3 --image=nginx:1.26.1 --dry-run=client -o yaml > green.yml

kubectl create service clusterip blue-green-svc --tcp=80:80 --dry-run=client -o yaml > service.yml

kubectl create configmap nginx-html-config --from-file=blue-index.html=./blue/index.html --from-file=green-index.html=./green/index.html --dry-run=client -o yaml > nginx-configmap.yml

# To verify the Blue Green, just update the selector in service.yml pointing from blue to green, while running the below pod side by side.
kubectl run cluster-tester --image=curlimages/curl --restart=Never -i --tty --rm -- \
  sh -c "while true; do curl -s --connect-timeout 2 http://blue-green-svc; echo ''; sleep 2; done"
```