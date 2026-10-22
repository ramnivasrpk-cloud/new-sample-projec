#!/usr/bin/env bash
set -Eeuo pipefail

container="${1:-}"
if [[ -z "$container" ]]; then
  echo "Usage: $0 <container-name-or-id>" >&2
  docker ps -a
  exit 2
fi

echo "=== Container status ==="
docker ps -a --filter "id=$container" --filter "name=$container"
echo "=== Recent logs ==="
docker logs --tail 100 "$container" || true
echo "=== Inspect (mounts, ports, exit code, restart policy) ==="
docker inspect "$container"
echo "=== Host resources ==="
docker stats --no-stream "$container" || true
