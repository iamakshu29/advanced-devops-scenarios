34. Centralized Secret strategy
Compare:
- K8s Secrets
- Vault
- AWS Secrets Manager

Implement One Securely

Goal: secrets like passwords and API keys should never sit in Git, in the image, or in plain-text manifests. Compare the three options, pick one, and show an app in Kubernetes reading its secret from a central, access-controlled place, with proof that only the allowed app can read it.

NOTES
- Created Secrets
    - Using kubectl simply
    - Retrieve from Secrets Manager and Use them diretly instead of Secrets. (more Secure)
        - Secrets Store CSI Driver + AWS Secrets and Configuration Provider (ASCP) — recommended for mounting secrets into pods.
        - External Secrets Operator (ESO) — retrieves secrets from Secrets Manager and creates Kubernetes Secrets.

- Using K8s Secrets, generic approach - applied in mysql.yml

- From SecretsManager
    - For CSI driver -> 
        - Install CSI
        - Provide IAM perms (IRSA, EKS Pod Identity)
        - Create SecretProviderClass
        - Mount it into the Pod using volumes and volumeMounts
    - External Secrets Operator ->
        - It Retrieves and synchronizes secrets and Creates a native Kubernetes Secret
        - then, we can simply like we inject the K8s Secrets.

- Only App can read it, for this create role, rolesbinding, serviceAccount and verify
    - kubectl auth can-i get secret/my-secret --as=system:serviceaccount:default:unauthorized-sa --> no
    - kubectl auth can-i get secret/my-secret --as=system:serviceaccount:default:dev-sa --> yes

- Use Kyverno Policy if you want to restrict the secret to be accessed by specific Pod only.