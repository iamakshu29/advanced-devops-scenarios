18. Kubernetes Network Policies
Implement
- Deny all Traffic
- Test-Pod -> Frontend only
- Frontend -> backend only
- Backend -> DB only
- Block else

Goal: only allow the traffic path frontend -> backend -> database, and block everything else, while still allowing DNS.

NOTES
- `default-deny-with-dns` selects all pods and lists both `Ingress` and `Egress` in `policyTypes` with no ingress rules, so all ingress is denied and egress is limited to DNS (kube-dns, port 53).
- Policies only add allows; the allowed traffic is the union of all policies that select a pod.
- A connection needs both sides to allow it: egress on the source pod and ingress on the destination pod.
- `policyTypes` controls what a policy applies to. An `ingress:` block is ignored if `Ingress` is not listed in `policyTypes`.
- `frontend-to-backend` lets frontend send only to backend on port 80 and accept traffic from `test-pod`; `backend-from-frontend-to-database` and `database-from-backend` allow only backend <- frontend and database <- backend.
- `test-pod-to-frontend` gives `test-pod` egress to frontend, because the default deny also blocks its egress. `kubectl run test-pod` sets the label `run=test-pod` automatically.
- Service selectors and policy selectors must match the pod labels (`app: frontend`, `app: backend`, `app: database`), not the Service names.
- Policies only work if the CNI enforces NetworkPolicy (Calico, Cilium, etc.). Test with `commands.md`; blocked connections time out.
