#!/usr/bin/env bash
set -Eeuo pipefail
: "${IMAGE_REPOSITORY:?Set IMAGE_REPOSITORY to your ECR repository URI}"
: "${IMAGE_TAG:?Set IMAGE_TAG to an immutable image tag}"
namespace="${NAMESPACE:-devops-demo}"
release="${RELEASE_NAME:-nodejs-app}"

helm upgrade --install "$release" ./helm/nodejs-app \
  --namespace "$namespace" --create-namespace \
  --set image.repository="$IMAGE_REPOSITORY" \
  --set image.tag="$IMAGE_TAG"
kubectl -n "$namespace" rollout status "deployment/$release-nodejs-app" --timeout=180s
