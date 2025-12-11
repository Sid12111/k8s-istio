#!/usr/bin/env bash
set -euo pipefail
CLUSTER_NAME=istio-demo
kind delete cluster --name ${CLUSTER_NAME} || true
kind create cluster --name ${CLUSTER_NAME} --config kind-config.yaml
kubectl cluster-info --context kind-${CLUSTER_NAME}
