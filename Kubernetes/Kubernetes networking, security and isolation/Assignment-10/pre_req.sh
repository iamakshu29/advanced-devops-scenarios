#!/bin/bash

echo "Install nginx ingress controller, if not already installed."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/cloud/deploy.yaml
echo "Nginx ingress controller installation initiated."

echo "Install cert-manager, if not already installed."
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.yaml
echo "Cert-manager installation initiated."

echo "Pre-requisites installation done."
