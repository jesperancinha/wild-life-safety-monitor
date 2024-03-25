SHELL := /bin/bash
GRADLE_VERSION ?= 8.5
MODULE_LOCATIONS := wlsm-aggregator-service \
					wlsm-collector-service \
					wlsm-listener-service \
					wlsm-management-service
MODULE_TAGS := aggregator \
			   collector \
			   listener \
			   management
b: buildw
build-root:
	gradle build
install-all:
	sudo npm install -g @angular/cli
	sudo apt-get install -y apt-transport-https ca-certificates curl gpg
	curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubelet kubeadm kubectl
	sudo apt-mark hold kubelet kubeadm kubectl
buildw: build-gradle
build-gradle:
	gradle wrapper
	./gradlew build test
	@for location in $(MODULE_LOCATIONS); do \
		export CURRENT=$(shell pwd); \
		echo "Building $$location..."; \
		cd $$location; \
		make b; \
		cd $$CURRENT; \
	done
create-local-registry:
	./registry-service.yaml
k8s-init: create-cluster create-local-registry k8s-apply-deployment
create-and-push-images:
	@for tag in $(MODULE_TAGS); do \
		export CURRENT=$(shell pwd); \
		echo "Building Image $$image..."; \
		cd "wlsm-"$$tag"-service"; \
		docker build . --tag localhost:5001/"wlsm-"$$tag"-service"; \
		docker push localhost:5001/"wlsm-"$$tag"-service"; \
		cd $$CURRENT; \
	done
create-cluster:
	kind create cluster --name=wlsm-mesh-zone
	kubectl cluster-info --context kind-wlsm-mesh-zone
logs:
	kubectl get pods --all-namespaces
	kubectl get svc
	kubectl get svc --all-namespaces -o=jsonpath='{range .items[*]}{"Namespace: "}{.metadata.namespace}{"\n"}{"Service: "}{.metadata.name}{"\n"}{"Ports:\n"}{range .spec.ports[*]}{"- Name: "}{.name}{"\n"}{"  Protocol: "}{.protocol}{"\n"}{"  Port: "}{.port}{"\n"}{"  TargetPort: "}{.targetPort}{"\n"}{"  NodePort: "}{.nodePort}{"\n"}{end}{"\n"}{end}'
k8s-apply-deployment:
	@for tag in $(MODULE_TAGS); do \
		export CURRENT=$(shell pwd); \
		echo "Applying File $$tag..."; \
		cd "wlsm-"$$tag"-service"; \
		kubectl apply -f $$tag-deployment.yaml; \
		cd $$CURRENT; \
	done
k8s-tear-aggregator-down:
	kubectl delete -f aggregator-deployment.yaml
k8s-tear-down: k8s-tear-aggregator-down
k8s-ubuntu-shell:
	kubectl exec --stdin --tty ubuntu  -- /bin/bash

# This is a set of different scripts used to try, create and test this project.
# They are not. however in use anymore for the project
k8s-init-start: k8s-apply-registry-deployment redirect-ports
create-local-registry: start-registry create-and-push-images
k8s-apply-aggregator-deployment:
	kubectl apply -f aggregator-deployment.yaml
k8s-apply-ubuntu-deployment:
	kubectl apply -f ubuntu.yaml
k8s-apply-registry-deployment:
	kubectl apply -f registry-deployment.yaml
k8s-tear-registry-down:
	kubectl delete -f registry-deployment.yaml
	kubectl delete -f registry-service.yaml
k8s-tear-ubuntu-down:
	kubectl delete -f ubuntu.yaml
k8s-tear-all-down: k8s-tear-aggregator-down k8s-tear-registry-down k8s-tear-ubuntu-down
redirect-ports:
	kubectl port-forward svc/wlsm-registry -n default 5000:5000
start-registry: stop-remove-registry
	docker run -d -p 5000:5000 --restart=always --name registry registry:2
stop-registry:
	docker ps -a --format '{{.ID}}' -q --filter="name=registry" | xargs -I {}  docker stop {}
remove-registry:
	docker ps -a --format '{{.ID}}' -q --filter="name=registry" | xargs -I {}  docker rm {}
stop-remove-registry: stop-registry remove-registry
