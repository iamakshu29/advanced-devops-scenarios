Horizontal & Vertical Scaling
Implement:
- HPA (CPU and Memory based)
- VPA (if supported)
- Load Testing to trigger scaling
- Document scaling behaviour

NOTES
- Create a Deployment named `scaling-demo-deploy` and a Service that targets its pods.
- Configure an HPA and a VPA for `scaling-demo-deploy`. For CPU or memory utilization targets, the HPA needs `resources.requests` for the corresponding resource; limits are optional.
- Generate load by continuously sending requests to the Service from a separate Deployment named `stress-test-deploy`.
- Observe how the HPA adjusts the replica count and how the VPA provides CPU and memory recommendations. Configure the VPA in recommendation mode when using it alongside an HPA that scales on CPU or memory utilization, so both controllers do not compete to manage the same resource requests.
