# k8-observability-istio-demo

Run a local kind cluster with Istio, Prometheus, Grafana and Kiali for testing and demos.

## Prerequisites
- Docker
- kind
- kubectl
- helm 3
- istioctl

## Quick start
```
make create-cluster
make install-istio
make install-observability
make install-kiali
make deploy-apps
make ports
```
