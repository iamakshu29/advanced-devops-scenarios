```bash
kubectl create deploy stable-version-deploy --replicas=3 --image=nginx:1.25.1 --dry-run=client -o yaml > stable_version.yml

kubectl create deploy canary-version-deploy --replicas=3 --image=nginx:1.26.1 --dry-run=client -o yaml > canary_version.yml

kubectl create configmap nginx-html-config --from-file=stable-index.html=./stable/index.html --from-file=canary-index.html=./canary/index.html --dry-run=client -o yaml > nginx-configmap.yml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

curl -H "Host: myapp.example.com" http://localhost:80

# In different windows, Run both shell script side by side
```

