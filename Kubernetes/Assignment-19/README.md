19. Canary Deployment
Implement:
- Using Ingress Annotations
    - nginx.ingress.kubernetes.io/canary: "true"
    - nginx.ingress.kubernetes.io/canary-weight: "5"
- 10% traffic to new Version
- Monitor error rate
- Promote Automatically

NOTES
- **Goal:** demonstrate a canary rollout with NGINX Ingress, routing a percentage of
  requests for `myapp.example.com` to the canary while the stable version remains available.
- **Stable workload:** `stable_version.yml` creates three NGINX 1.25.1 replicas and
  `stable-svc`. **Canary workload:** `canary_version.yml` creates three NGINX 1.26.1
  replicas and `canary-svc`.
- `nginx-configmap.yml` supplies the stable and canary HTML pages. Each Deployment
  mounts its respective ConfigMap key as `/usr/share/nginx/html/index.html`.
- `ingress.yml` defines the stable route and a canary route for the same host and path.
  The canary is enabled by `nginx.ingress.kubernetes.io/canary`; its
  `nginx.ingress.kubernetes.io/canary-weight` annotation controls the canary traffic
  percentage.
- **Configuration mismatch:** the assignment calls for an initial 5% canary weight,
  but `ingress.yml` currently sets it to 50%. Set it to `"5"` before applying the
  manifests if the rollout should start at the requested percentage.
- **Apply order:** after installing the NGINX Ingress controller, apply the ConfigMap,
  both workload manifests, and then the Ingress rules:

  ```bash
  kubectl apply -f nginx-configmap.yml
  kubectl apply -f stable_version.yml
  kubectl apply -f canary_version.yml
  kubectl apply -f ingress.yml
  ```

- `hit_url.sh` repeatedly sends requests to the local Ingress endpoint with the
  expected Host header. Use it to observe which version responds; the endpoint and
  Host header must match the local Ingress setup.
- `increase_traffic.sh` waits 15 seconds between annotation updates and raises the
  weight to 10%, 30%, 50%, and 100%. It is a **timed progression, not automatic
  promotion based on health**: no error-rate measurement, threshold check, or
  rollback is implemented. Monitor errors separately and stop or reduce the weight
  if the canary is unhealthy.