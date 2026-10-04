Self Healing Kubernetes App
Deploy an app that:
- Crashes randomly
- Must Restart Automatically
- Configure liveness & readiness probes
- Show logs proving self-healing

NOTES
- Create a Pod for an application that can be made to fail or exit intermittently. Add a Service only if you also want to test traffic availability.
- Configure a liveness probe to detect a hung or unhealthy container; Kubernetes restarts the container when this probe fails repeatedly.
- Configure a readiness probe to indicate when the application can accept traffic. An unready pod is removed from Service endpoints but is not restarted solely because its readiness probe fails.
- Trigger or simulate an application failure, then inspect pod status, events, and container logs to verify that Kubernetes restarted the container and the application recovered.