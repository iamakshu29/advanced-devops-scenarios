Rolling Restart with Zero downtime
Simulate production restart:
- maintain 100% uptime
- Monitor availability

Goal:  when you restart/update a running app in Kubernetes (e.g. after a config change), users should never see downtime and prove it with monitoring.

NOTES
- Create a Deployment named `rolling-restart-zero-downtime` and a Service that routes traffic to its pods.
- Configure the Deployment's rolling update strategy with `maxUnavailable: 0` and `maxSurge: 1`.
- Add a readiness probe so Kubernetes sends traffic only to ready pods; with enough cluster capacity, old pods can remain available while replacement pods start.
- Update the container image tag and continuously send requests to the Service while the rollout runs. Monitor the responses for failures to check whether the update avoids downtime by checking logs of `zero_downtime_check` pod.