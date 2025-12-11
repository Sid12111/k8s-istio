.PHONY: create-cluster delete-cluster install-istio install-observability install-kiali deploy-apps ports

create-cluster:
	bash kind-cluster/create-cluster.sh

delete-cluster:
	kind delete cluster --name istio-demo || true

install-istio:
	bash istio/install-istio.sh

install-observability:
	bash observability/install-observability.sh

install-kiali:
	bash kiali/install-kiali.sh

deploy-apps:
	kubectl apply -f apps/demo-app.yaml
	kubectl apply -f apps/gateway-and-virtualservice.yaml

ports:
	kubectl -n istio-system port-forward svc/kiali 20001:20001 & \
	kubectl -n istio-system port-forward svc/grafana 3000:3000 & \
	kubectl -n istio-system port-forward svc/prometheus 9090:9090 & \
	echo "Port-forwards: Kiali: http://localhost:20001, Grafana: http://localhost:3000, Prometheus: http://localhost:9090"
