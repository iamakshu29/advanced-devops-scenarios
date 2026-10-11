10. Ingress with TLS
Deploy:
- NGINX Ingress controller
- Let's Encrypt Certificate
- Domain Routing
- HTTPS redirection

```bash
kubectl create deploy nginx --replicas=1 --image=nginx:latest --dry-run=client -o yaml > deploy.yml

kubectl create ingress nginx-ingress --host="" --dry-run=client -o yaml > ingress.yml
```