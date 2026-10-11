#!/bin/bash

echo "This script will increase traffic to the canary deployment gradually."
echo "As traffic is increased gradually, monitor the application to ensure stability."

sleep 15
echo "Increasing traffic to the canary deployment from 5 to 10 percent"
kubectl annotate ingress canary-ingress nginx.ingress.kubernetes.io/canary-weight="10" --overwrite

sleep 15
echo "Increasing traffic to the canary deployment from 10 to 30 percent"
kubectl annotate ingress canary-ingress nginx.ingress.kubernetes.io/canary-weight="30" --overwrite

sleep 15
echo "Increasing traffic to the canary deployment from 30 to 50 percent"
kubectl annotate ingress canary-ingress nginx.ingress.kubernetes.io/canary-weight="50" --overwrite

sleep 15
echo "Increasing traffic to the canary deployment from 50 to 100 percent"
kubectl annotate ingress canary-ingress nginx.ingress.kubernetes.io/canary-weight="100" --overwrite

echo "Canary deployment is now receiving 100% of the traffic."