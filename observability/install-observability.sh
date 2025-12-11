#!/usr/bin/env bash
set -euo pipefail
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
kubectl create ns monitoring || true
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack -n monitoring --values prometheus-values.yaml --wait
helm upgrade --install grafana grafana/grafana -n monitoring --values grafana-values.yaml --wait
