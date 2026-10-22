#!/usr/bin/env bash
set -Eeuo pipefail
namespace="${1:-devops-demo}"
deployment="${2:-nodejs-app}"

kubectl -n "$namespace" rollout status "deployment/$deployment" --timeout=180s
kubectl -n "$namespace" get deployment,pods,svc,ingress -o wide
kubectl -n "$namespace" describe "deployment/$deployment"
