18. Kubernetes Network Policies
Implement
- Using Ingress Annotations
    - nginx.ingress.kubernetes.io/canary: "true"
    - nginx.ingress.kubernetes.io/canary-weight: "5"
- Deny all Traffic
- Allow Frontend -> backend only
- Block Backend -> frontend

Verify using curl Tests
