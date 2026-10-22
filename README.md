# Real-World DevOps Project: Node.js on AWS EKS

A practical interview-ready starter repository demonstrating Linux/Bash operations, Docker, Docker Compose, Kubernetes, Helm, Argo CD, Terraform, Jenkins, and AWS ECR/EKS deployment patterns.

## Architecture

Developer push -> GitHub -> Jenkins -> test/build -> Trivy scan -> Amazon ECR -> Kubernetes deployment on EKS -> Prometheus/Grafana monitoring.

Terraform provisions the network and supporting AWS resources. For a production EKS cluster, use a reviewed EKS module or your organization's approved platform module; the Terraform here is a safe, extensible foundation rather than a complete production EKS platform.

## Repository map

- `app/`: sample Node.js service
- `scripts/`: Linux/Bash utility and deployment scripts
- `docker/`: Dockerfile, multi-stage Dockerfile, Compose
- `k8s/`: Deployment, Service, Ingress, ConfigMap, HPA, probes, namespace
- `helm/nodejs-app/`: Helm chart
- `argocd/`: Argo CD Application
- `terraform/`: VPC, ECR, IAM example, remote state bootstrap notes
- `jenkins/`: Jenkinsfile and shared pipeline snippets
- `.github/workflows/`: optional CI example
- `monitoring/`: Prometheus scrape configuration

## Before running

1. Replace all example account IDs, regions, domain names, and repository names.
2. Never commit AWS keys, PEM keys, passwords, kubeconfig files, Terraform state, or `.env` files.
3. Use IAM roles/instance profiles or OIDC federation rather than long-lived access keys.
4. Run `terraform fmt -recursive`, `terraform validate`, `helm lint`, and image scans before deployment.
5. The sample app is for learning; add authentication, TLS, secrets management, and application-specific security before production use.

## Local app

```bash
cd app
npm install
npm start
curl http://localhost:3000/health
```

## Docker

```bash
docker build -f docker/Dockerfile.multistage -t nodejs-app:local .
docker run --rm -p 3000:3000 nodejs-app:local
docker compose -f docker/compose.yaml up --build
```

## Kubernetes

Update image in `k8s/deployment.yaml`, then:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/
kubectl -n devops-demo get pods,svc,ingress
```

## Terraform

Review `terraform/README.md` before running anything. Terraform can create billable AWS resources.
