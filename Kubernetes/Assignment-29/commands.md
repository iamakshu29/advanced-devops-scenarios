kubectl create deployment rolling-restart-zero-downtime --replicas=3 --image=nginx --dry-run=client -o yaml > deployment.yml

kubectl port-forward deployment/rolling-restart-zero-downtime 81:80


kubectl expose deployment rolling-restart-zero-downtime --port=81 --target-port=80


kubectl set image deployment/rolling-restart-zero-downtime nginx=nginx:latest

kubectl run test-pod --image=curlimages/curl --command -- sleep 3600
To check While updating image
kubectl exec test-pod -- sh -c 'while true; do curl -I rolling-restart-zero-downtime:81; sleep 3; done'
