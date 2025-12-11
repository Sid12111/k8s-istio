#!/usr/bin/env bash
set -euo pipefail
kubectl create ns istio-system || true
istioctl x addons enable kiali
kubectl -n istio-system rollout status deployment kiali -w
