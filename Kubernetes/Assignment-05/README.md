Blue/Green Deployment (AWS + Kubernetes)
Deploy an app using 
- EKS
- ALB
- Two Version (v1, v2)
- Gradual Traffic Switch
Rollback on Failure.

HOW TO -
a. Simply change the service selector label to green from blue.
b. (How Companies do is through argoCD) using Ingress - Create 2 separate Service, and point the ingress path to new version service.
    So its like same logic as a, just one step higher up the network stack.


NOTES
- Apply `nginx-configmap.yml` before the Deployments so the referenced ConfigMap exists.
- Each Deployment mounts the ConfigMap at `/usr/share/nginx/html`; its version-specific HTML file is exposed as `index.html`.
- The ConfigMap volume is read-only. Do not use it for data that the container needs to write.
- Keep each Deployment's pod labels aligned with its Service selector. The Services provide stable endpoints for the Blue and Green versions.
- There are two ways to implement Blue Green Deployment.
    - a. By simply changing the selector label from blue to green in `service.yml`.
    - b. `(Commonly Used By Companies)` By changing the Ingress backend (or the active Service selector) from Blue to Green Service. Roll back by switching it to Blue again.
- Verify the response before and after switching with the curl loop in `commands.md`.
- The included Ingress uses the NGINX Ingress Controller. For EKS with an AWS ALB, configure an AWS Load Balancer Controller Ingress separately.