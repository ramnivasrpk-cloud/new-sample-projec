#!/usr/bin/env bash
set -Eeuo pipefail

namespace="${1:-default}"
selector="${2:-app=nodejs-app}"

echo "Namespace=$namespace selector=$selector"
kubectl -n "$namespace" get pods -o wide -l "$selector"
for pod in $(kubectl -n "$namespace" get pods -l "$selector" -o name); do
  echo "===== $pod describe ====="
  kubectl -n "$namespace" describe "$pod" || true
  echo "===== $pod current logs ====="
  kubectl -n "$namespace" logs "$pod" --all-containers=true --tail=100 || true
  echo "===== $pod previous logs ====="
  kubectl -n "$namespace" logs "$pod" --all-containers=true --previous --tail=100 || true
done
kubectl -n "$namespace" get events --sort-by=.lastTimestamp | tail -n 30
