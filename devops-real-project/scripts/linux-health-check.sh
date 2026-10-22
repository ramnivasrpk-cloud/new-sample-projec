#!/usr/bin/env bash
set -Eeuo pipefail

echo "=== Host ==="
hostname
date -Is
uptime

echo "=== CPU / processes ==="
top -b -n1 | head -n 15 || true

echo "=== Memory ==="
free -h

echo "=== Filesystems ==="
df -hT

echo "=== Largest directories in /var (may require sudo) ==="
sudo du -xhd1 /var 2>/dev/null | sort -h | tail -n 10 || true

echo "=== Failed systemd units ==="
systemctl --failed --no-pager || true
