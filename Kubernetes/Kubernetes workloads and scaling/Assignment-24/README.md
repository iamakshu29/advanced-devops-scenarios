Auto-Rollback on Health Failure
Configure:
- Kubernetes Deployment
- health probe
- Automatic rollback if Failure

Goal: when you roll out a new version of an app and it starts failing its health checks (e.g. bad build, broken config), Kubernetes should detect the failure and automatically roll back to the last healthy version instead of leaving users on a broken deployment.



NOTES
- Create a Deployment named `auto-rollback-deploy` and configure liveness and readiness probes to check the application’s health.
- Create an `auto_rollback_script.sh` script to demonstrate rollback after an unsuccessful rollout. Kubernetes Deployments do not automatically roll back on their own, so the script should initiate the rollback.
- Have the script update the Deployment to use an image that cannot serve the expected application traffic. The readiness probe should fail, keeping the new pod out of Service traffic.
- Use a timeout with `kubectl rollout status` to detect when the rollout does not complete successfully. If it fails (exit code > 0), use `kubectl rollout undo` to restore the previous Deployment revision.
