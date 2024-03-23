SHELL := /bin/bash
GRADLE_VERSION ?= 8.5
MODULE_LOCATIONS := wlsm-aggregator-service \
					wlsm-collector-service \
					wlsm-listener-service \
					wlsm-management-service

install-all:
	sudo npm install -g @angular/cli
	sudo apt-get install -y apt-transport-https ca-certificates curl gpg
	curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubelet kubeadm kubectl
	sudo apt-mark hold kubelet kubeadm kubectl
b: build
build: build-gradle
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
stop-registry:
	docker stop registry
remove-registry:
	docker rm registry
stop-remove-registry: stop-registry remove-registry
start-kubernetes:
	docker run -d -p 5000:5000 --restart=always --name registry registry:2
	cd wlsm-aggregator-service; \
	docker build . --tag localhost:5000/wlsm-aggregator-service; \
	docker push localhost:5000/wlsm-aggregator-service; \
	docker pull localhost:5000/wlsm-aggregator-service;
create-cluster:
	kind create cluster --name=wlsm-mesh-zone
	kubectl cluster-info --context kind-wlsm-mesh-zone
k8s-apply-deployment:
	kubectl apply -f deployment.yaml
k8s-tear-down:
	kubectl delete -f deployment.yaml
logs:
	kubectl get pods --all-namespaces
