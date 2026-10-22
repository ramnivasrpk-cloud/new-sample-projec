# Production troubleshooting quick reference

## Linux
```bash
uptime
top
free -h
df -h
du -xhd1 /var | sort -h
ss -lntp
systemctl --failed
journalctl -u SERVICE_NAME --since "30 minutes ago"
curl -v http://127.0.0.1:PORT/health
```

## Docker
```bash
docker ps -a
docker logs --tail 200 CONTAINER
docker inspect CONTAINER
docker stats --no-stream
docker exec -it CONTAINER sh   # only if the container is running and shell exists
```

## Kubernetes
```bash
kubectl get pods -A -o wide
kubectl describe pod POD -n NAMESPACE
kubectl logs POD -n NAMESPACE --all-containers
kubectl logs POD -n NAMESPACE --previous
kubectl get events -n NAMESPACE --sort-by=.lastTimestamp
kubectl get svc,endpoints,ingress -n NAMESPACE
kubectl rollout status deployment/NAME -n NAMESPACE
kubectl rollout history deployment/NAME -n NAMESPACE
kubectl rollout undo deployment/NAME -n NAMESPACE
kubectl top pods -n NAMESPACE
```

## AWS / ECR / EKS
```bash
aws sts get-caller-identity
aws ec2 describe-route-tables --region ap-south-1
aws ecr describe-repositories --region ap-south-1
aws eks describe-cluster --name CLUSTER --region ap-south-1
aws eks update-kubeconfig --name CLUSTER --region ap-south-1
```

For ECR pull failures, check: node/pod identity permissions, repository policy, correct account/region/repository/tag, private subnet route or ECR API + ECR DKR + S3 VPC endpoints, DNS, security group/NACL egress, and imagePullSecrets only when using credentials that require them.
