#!/bin/bash

echo "This script is to check if the deployment, pod, service are bound to RBAC roles defined in the namespace."
echo "It will help ensure that the necessary permissions are correctly applied."

echo "Reader Role has the following permissions: get, list, watch for resource: deployments, pods, services"
kubectl auth can-i get deployments --as=system:serviceaccount:default:sa-read
kubectl auth can-i get pods --as=system:serviceaccount:default:sa-read
kubectl auth can-i get services --as=system:serviceaccount:default:sa-read

kubectl auth can-i list deployments --as=system:serviceaccount:default:sa-read
kubectl auth can-i list pods --as=system:serviceaccount:default:sa-read
kubectl auth can-i list services --as=system:serviceaccount:default:sa-read

kubectl auth can-i watch deployments --as=system:serviceaccount:default:sa-read
kubectl auth can-i watch pods --as=system:serviceaccount:default:sa-read
kubectl auth can-i watch services --as=system:serviceaccount:default:sa-read

echo "Developer Role has the following permissions: get, list, watch, create, delete, update, patch for resource: deployments, pods, services"
kubectl auth can-i get deployments --as=system:serviceaccount:default:sa-dev
kubectl auth can-i get pods --as=system:serviceaccount:default:sa-dev
kubectl auth can-i get services --as=system:serviceaccount:default:sa-dev

kubectl auth can-i list deployments --as=system:serviceaccount:default:sa-dev
kubectl auth can-i list pods --as=system:serviceaccount:default:sa-dev
kubectl auth can-i list services --as=system:serviceaccount:default:sa-dev

kubectl auth can-i watch deployments --as=system:serviceaccount:default:sa-dev
kubectl auth can-i watch pods --as=system:serviceaccount:default:sa-dev
kubectl auth can-i watch services --as=system:serviceaccount:default:sa-dev

kubectl auth can-i create deployments --as=system:serviceaccount:default:sa-dev
kubectl auth can-i create pods --as=system:serviceaccount:default:sa-dev
kubectl auth can-i create services --as=system:serviceaccount:default:sa-dev

kubectl auth can-i delete deployments --as=system:serviceaccount:default:sa-dev
kubectl auth can-i delete pods --as=system:serviceaccount:default:sa-dev
kubectl auth can-i delete services --as=system:serviceaccount:default:sa-dev

kubectl auth can-i update deployments --as=system:serviceaccount:default:sa-dev
kubectl auth can-i update pods --as=system:serviceaccount:default:sa-dev
kubectl auth can-i update services --as=system:serviceaccount:default:sa-dev

kubectl auth can-i patch deployments --as=system:serviceaccount:default:sa-dev
kubectl auth can-i patch pods --as=system:serviceaccount:default:sa-dev
kubectl auth can-i patch services --as=system:serviceaccount:default:sa-dev

echo "Admin Role has all the permissions for all resources"
kubectl auth can-i get deployments --as=system:serviceaccount:default:sa-admin
kubectl auth can-i list pods --as=system:serviceaccount:default:sa-admin
kubectl auth can-i watch services --as=system:serviceaccount:default:sa-admin
kubectl auth can-i create deployments --as=system:serviceaccount:default:sa-admin
kubectl auth can-i update pods --as=system:serviceaccount:default:sa-admin
kubectl auth can-i delete services --as=system:serviceaccount:default:sa-admin