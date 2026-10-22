#!/usr/bin/env bash
set -Eeuo pipefail
: "${AWS_REGION:?Set AWS_REGION, e.g. ap-south-1}"
: "${AWS_ACCOUNT_ID:?Set AWS_ACCOUNT_ID}"

# Uses the caller's AWS CLI identity (prefer an IAM role or SSO).
aws sts get-caller-identity
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin \
    "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
