#!/bin/bash

kubectl apply -f deploy.yml

kubectl set image deploy auto-rollback-deploy nginx=tomcat:latest

kubectl rollout status deployment auto-rollback-deploy --timeout=60s

if [ $? -ne 0 ]; then
    echo "Rolling back deployment auto-rollback-deploy due to failed rollout."
    kubectl rollout undo deployment auto-rollback-deploy
fi

kubectl get deployment auto-rollback-deploy
