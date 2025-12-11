# 🚀 K8 Observability + Istio Demo Project

A **production-style Kubernetes observability stack** that includes: -
**Istio Service Mesh** -- traffic management, mTLS, Envoy sidecars,
telemetry - **Prometheus** -- metrics scraping from pods, Istio proxies
& system components - **Grafana** -- real dashboards for mesh, latency,
throughput & workload health - **Kiali** -- full service-mesh topology
visualization - **Demo Microservice App** -- routed via Istio Gateway -
**Kind Local Kubernetes Cluster** -- for 100% reproducible environment -
**Makefile** -- one-command automation

This project is perfect for: - DevOps & SRE interview prep -
Observability learning - Service mesh understanding - Local
experimentation without cloud costs

------------------------------------------------------------------------

# 📁 Project Structure Explained

    k8-observability-istio-demo/
    ├── README.md                       # Main documentation
    ├── Makefile                        # Automation commands
    ├── kind-cluster/
    │   ├── kind-config.yaml            # Kind cluster networking, ports, nodes
    │   └── create-cluster.sh           # Script to create the Kind cluster
    ├── istio/
    │   ├── istio-operator-values.yaml  # Istio operator configuration
    │   └── install-istio.sh            # Script to install Istio
    ├── observability/
    │   ├── prometheus-values.yaml      # Prometheus Helm chart values
    │   ├── grafana-values.yaml         # Grafana Helm chart values
    │   └── install-observability.sh    # Script to install monitoring stack
    ├── kiali/
    │   └── install-kiali.sh            # Script to install Kiali dashboard
    ├── apps/
    │   ├── demo-app.yaml               # Sample microservice deployment & service
    │   └── gateway-and-virtualservice.yaml  # Istio routing
    └── docs/
        └── usage.md                    # How to use dashboards & verify traffic

------------------------------------------------------------------------

# 🔥 How the Whole System Works (Flow Overview)

### **1️⃣ Kind Cluster Creation**

A local multi-node Kubernetes cluster is created using
`kind-config.yaml` which exposes ports: - 80 → Istio IngressGateway
HTTP - 443 → Istio HTTPS

### **2️⃣ Istio Installation**

The `install-istio.sh` script installs: - Istio operator - Istio control
plane (`istiod`) - IngressGateway - Sidecar injector

Istio then automatically injects Envoy sidecars into all app pods.

### **3️⃣ Observability Stack Deployment**

Using Helm values files: - **Prometheus** scrapes telemetry from Istio,
K8s components & workloads - **Grafana** loads prebuilt Istio
dashboards - **Kiali** connects to Prometheus + Istio to visualize mesh
topology

### **4️⃣ Demo Application Deployment**

The sample app (`demo-app.yaml`) runs inside the mesh.

All its traffic flows:

Client → Istio IngressGateway → VirtualService → Envoy Sidecar →
Application Pod

### **5️⃣ Traffic Routing (Gateway + VirtualService)**

`gateway-and-virtualservice.yaml` exposes the app externally: - Gateway
opens port 80 on Istio ingress - VirtualService routes requests to the
demo service

### **6️⃣ Observability in Action**

-   Prometheus collects:
    -   request count
    -   p99 latency
    -   app + proxy CPU/memory
    -   mesh metrics
-   Grafana visualizes:
    -   Istio Service Mesh Dashboard
    -   Workload & Namespace level dashboards
-   Kiali shows:
    -   Realtime traffic map
    -   Error rates
    -   Request flows

------------------------------------------------------------------------

# ⚙️ Prerequisites

Install: - Docker - kubectl - Kind - Helm - istioctl

------------------------------------------------------------------------

# 🛠 Installation --- Step by Step

## **1️⃣ Create Kind Cluster**

    bash kind-cluster/create-cluster.sh

## **2️⃣ Install Istio**

    bash istio/install-istio.sh

## **3️⃣ Install Observability Stack**

    bash observability/install-observability.sh

## **4️⃣ Install Kiali Dashboard**

    bash kiali/install-kiali.sh

## **5️⃣ Deploy Demo Application**

    kubectl apply -f apps/demo-app.yaml
    kubectl apply -f apps/gateway-and-virtualservice.yaml

------------------------------------------------------------------------

# 📊 Accessing Dashboards

### **🔹 Istio IngressGateway (App)**

    http://localhost

### **🔹 Prometheus**

    kubectl port-forward svc/prometheus 9090:9090 -n monitoring
    http://localhost:9090

### **🔹 Grafana**

    kubectl port-forward svc/grafana 3000:3000 -n monitoring
    http://localhost:3000

Default login: - user: admin - pass: admin

### **🔹 Kiali**

    kubectl port-forward svc/kiali 20001:20001 -n istio-system
    http://localhost:20001

------------------------------------------------------------------------

# 🧪 What You Can Test

-   Latency, success rate & RPS in Grafana
-   Mesh graph & traffic flow in Kiali
-   PromQL queries in Prometheus
-   Istio routing behavior (modify VirtualService)
-   Fault injection, retries, circuit breaking

------------------------------------------------------------------------

# 🏁 Useful Makefile Commands

    make cluster        # Create kind cluster
    make istio          # Install Istio
    make monitoring     # Install Prometheus + Grafana
    make kiali          # Install Kiali
    make app            # Deploy demo app
    make destroy        # Delete cluster

------------------------------------------------------------------------
