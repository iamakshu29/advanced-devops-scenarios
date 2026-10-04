#!/bin/bash

echo "Setting up prerequisites for scaling-demo-deploy..."
echo
echo "Installing Metrics Server"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
echo
echo "Applying Vertical Pod Autoscaler RBAC and CRDs"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-v1-crd-gen.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-rbac.yaml
echo
echo "Cloning Vertical Pod Autoscaler repository to install VPA"
git clone https://github.com/kubernetes/autoscaler.git
echo "Navigating to autoscaler directory and setting up VPA by running the script..."
cd autoscaler/vertical-pod-autoscaler
./hack/vpa-up.sh
echo
echo "Verify"
kubectl get pods -n kube-system | grep vpa
echo "Cleaning up cloned autoscaler repository..."
rm -rf autoscaler
echo "Returned to the original directory."
cd ../../..
echo
echo "Prerequisites setup completed."
echo
echo "Now you can deploy your scaling-demo-deploy application and set up HPA and VPA."
kubectl apply -f deployment.yml hpa.yml vpa.yml
echo
echo "Exposing scaling-demo-deploy deployment."
kubectl expose deployment scaling-demo-deploy --port=80 --target-port=80
echo
echo "Running stress-test deployment for stressing load on scaling-demo-deploy service..."
kubectl apply -f stress_test.yml
echo
sleep 60
echo "VPA should be getting Recommendations by now."
kubectl describe vpa my-app-vpa