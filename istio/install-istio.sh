#!/usr/bin/env bash
set -euo pipefail
ISTIO_VERSION=1.21.4
if ! command -v istioctl &>/dev/null; then
  echo "istioctl not found"
  exit 1
fi
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled --overwrite
