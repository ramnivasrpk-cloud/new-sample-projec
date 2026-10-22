# Jenkins setup checklist

Install/configure the Pipeline, Git, Credentials Binding, and (if used above) Pipeline: AWS Steps plugins. Configure:
- Credential ID `aws-deploy-role` using an approved AWS credential mechanism. Prefer instance profile/assume-role or OIDC; do not hardcode keys.
- Jenkins agent with Docker CLI/daemon access, AWS CLI v2, kubectl, Node.js, and Trivy.
- IAM permissions limited to pushing to the target ECR repo and updating the intended EKS cluster.
- EKS access entry/RBAC for the deployment identity.
- Replace `REPLACE_WITH_EKS_CLUSTER`.
- Use protected branches, required reviews, pinned tools, and an approval gate for production.
- In mature setups, use a separate deploy role, image digest pinning, SBOM generation, signed images, and separate build/deploy stages.
