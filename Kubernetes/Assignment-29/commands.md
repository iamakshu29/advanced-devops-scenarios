kubectl create deployment rolling-restart-zero-downtime-deploy --replicas=3 --image=nginx --dry-run=client -o yaml > deployment.yml

kubectl expose deployment rolling-restart-zero-downtime-deploy --port=80 --target-port=80

kubectl set image deployment/rolling-restart-zero-downtime-deploy nginx=nginx:latest
