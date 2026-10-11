```bash
kubectl create deployment rolling-restart-zero-downtime-deploy --replicas=3 --image=nginx --dry-run=client -o yaml > deployment.yml

kubectl expose deployment rolling-restart-zero-downtime-deploy --port=80 --target-port=80

kubectl set image deployment/rolling-restart-zero-downtime-deploy nginx=nginx:latest

kubectl run cluster-tester --image=curlimages/curl --restart=Never -i --tty --rm -- \
  sh -c "while true; do curl -s --connect-timeout 2 http://rolling-restart-zero-downtime-deploy > /dev/null && echo "OK" || echo "FAILED"; echo ''; sleep 3; done"
```

