include Makefile.mk

MODULE_LOCATIONS := wlsm-aggregator-service \
					wlsm-collector-service \
					wlsm-listener-service \
					wlsm-management-service
MODULE_TAGS := aggregator \
			   collector \
			   listener \
			   management \
			   database
b: buildw
build-research:
	cd wlsm-messenger-pre-service; \
	make install-protobuf; \
	make install-plugin; \
	make protoc-gen
build-root:
	gradle build
install-all:
	sudo npm install -g @angular/cli
	[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/local/bin/kind
	sudo apt-get install -y apt-transport-https ca-certificates curl gpg
	curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
	sudo apt-get update
	sudo apt-get install -y kubelet kubeadm kubectl helm
	#sudo apt-mark hold kubelet kubeadm kubectl helm
	cd ~; \
	curl -L https://kuma.io/installer.sh | VERSION=2.6.1 sh -
remove-all-cluster:
	kind delete clusters --all
uninstall-all:
	kind delete clusters --all
	if [ -f /usr/local/bin/kind ]; then sudo rm /usr/local/bin/kind; fi
	if [ -d ~/kuma-* ]; then sudo rm -r ~/kuma-*; fi
	sudo apt remove kubelet kubeadm kubectl helm
	sudo apt autoremove
	if [ -f /usr/local/bin/kubectl ]; then sudo rm /usr/local/bin/kubectl; fi
	if [ -f /usr/local/bin/helm ]; then sudo rm /usr/local/bin/helm; fi
setup-kuma:
	helm repo add kuma https://kumahq.github.io/charts
	helm repo update
	helm install --create-namespace --namespace kuma-system kuma kuma/kuma
buildw: build-gradle
build-gradle:
	export GRADLE_VERSION=$(GRADLE_VERSION) ;\
	gradle wrapper --no-validate-url --gradle-version $(GRADLE_VERSION); \
	./gradlew build test
	@for location in $(MODULE_LOCATIONS); do \
		export CURRENT=$(shell pwd); \
		echo "Building $$location..."; \
		cd $$location; \
		make b; \
		cd $$CURRENT; \
	done
k8s-init: remove-all-cluster b create-cluster create-local-registry create-and-push-images k8s-apply-deployment
create-and-push-images: k8s-tear-down
	#docker images -f "dangling=true" -q | xargs -I {}  docker rmi {}
	docker images "*/*wlsm*" --format '{{.Repository}}' | xargs -I {}  docker rmi {}
	@for tag in $(MODULE_TAGS); do \
		export CURRENT=$(shell pwd); \
		echo "Building Image $$image..."; \
		cd "wlsm-"$$tag"-service"; \
		docker build . --tag localhost:5001/"wlsm-"$$tag"-service"; \
		docker push localhost:5001/"wlsm-"$$tag"-service"; \
		cd $$CURRENT; \
	done
create-database-image:
	cd wlsm-database; \
	docker build . --tag localhost:5001/wlsm-database ;\
	docker push localhost:5001/wlsm-database
create-cluster:
	kind create cluster --name=wlsm-mesh-zone
	kubectl cluster-info --context kind-wlsm-mesh-zone
status-pods: log-pods
log-pods:
	kubectl get pods --all-namespaces
logs: log-pods
	kubectl get svc
	kubectl get svc --all-namespaces -o=jsonpath='{range .items[*]}{"Namespace: "}{.metadata.namespace}{"\n"}{"Service: "}{.metadata.name}{"\n"}{"Ports:\n"}{range .spec.ports[*]}{"- Name: "}{.name}{"\n"}{"  Protocol: "}{.protocol}{"\n"}{"  Port: "}{.port}{"\n"}{"  TargetPort: "}{.targetPort}{"\n"}{"  NodePort: "}{.nodePort}{"\n"}{end}{"\n"}{end}'
k8s-apply-deployment:
	@for tag in $(MODULE_TAGS); do \
		export CURRENT=$(shell pwd); \
		echo "Applying File $$tag..."; \
		cd "wlsm-"$$tag"-service"; \
		kubectl apply -f $$tag-deployment.yaml --force; \
		cd $$CURRENT; \
	done
k8s-restart-pods:
	kubectl delete pods --all -n wlsm-namespace
k8s-tear-aggregator-down:
	kubectl delete -f aggregator-deployment.yaml
k8s-tear-down:
	@for tag in $(MODULE_TAGS); do \
		export CURRENT=$(shell pwd); \
		echo "Tearing down $$tag..."; \
		cd "wlsm-"$$tag"-service"; \
		kubectl delete -f $$tag-deployment.yaml --ignore-not-found=true; \
		cd $$CURRENT; \
	done
k8s-ubuntu-shell:
	kubectl exec --stdin --tty wlsm-listener-deployment  -- /bin/bash

# This is a set of different scripts used to try, create and test this project.
# They are not. however in use anymore for the project
k8s-dns-check:
	kubectl exec -ti wlsm-collector-5744c9b896-2k6b4 -n wlsm-namespace -- nslookup kubernetes.default
k8s-init-start: k8s-apply-registry-deployment redirect-ports
create-local-registry: start-registry
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
	kubectl port-forward svc/wlsm-listener-deployment -n wlsm-namespace 8080:8080
	kubectl port-forward svc/wlsm-collector-deployment -n wlsm-namespace 8081:8081
	kubectl port-forward svc/wlsm-database-deployment -n wlsm-namespace 5432:5432
	kubectl port-forward svc/kuma-control-plane -n kuma-system 5681:5681
open-all-ports:
	kubectl port-forward svc/wlsm-listener-deployment -n wlsm-namespace 8080:8080 &
	kubectl port-forward svc/wlsm-collector-deployment -n wlsm-namespace 8081:8081 &
	kubectl port-forward svc/wlsm-database-deployment -n wlsm-namespace 5432:5432 &
	kubectl port-forward svc/kuma-control-plane -n kuma-system 5681:5681 &
stop-close-all-ports:
	killall kubectl
start-registry: stop-remove-registry
	./kind-with-registry.sh
stop-registry:
	docker ps -a --format '{{.ID}}' -q --filter="name=registry" | xargs -I {}  docker stop {}
remove-registry: stop-registry
	docker ps -a --format '{{.ID}}' -q --filter="name=registry" | xargs -I {}  docker rm {}
stop-remove-registry: stop-registry remove-registry
check-mtls:
	kumactl get mesh default -oyaml
remove-lock-files:
	find . -name "package-lock.json" | xargs -I {} rm {}; \
	find . -name "yarn.lock" | xargs -I {} rm {};
update: remove-lock-files
	git pull
	npm install caniuse-lite
	npm install -g npm-check-updates
	cd wslm-gui; \
 		yarn; \
 		npx browserslist --update-db; \
 		ncu -u; \
 		yarn
	cd wslm-frontend; \
 		yarn; \
 		npx browserslist --update-db; \
 		ncu -u; \
 		yarn
deps-update: update
revert-deps-cypress-update:
	if [ -f  e2e/docker-composetmp.yml ]; then rm e2e/docker-composetmp.yml; fi
	if [ -f  e2e/packagetmp.json ]; then rm e2e/packagetmp.json; fi
	git checkout e2e/docker-compose.yml
	git checkout e2e/package.json
deps-plugins-update:
	curl -sL https://raw.githubusercontent.com/jesperancinha/project-signer/master/pluginUpdatesOne.sh | bash
deps-java-update:
	curl -sL https://raw.githubusercontent.com/jesperancinha/project-signer/master/javaUpdatesOne.sh | bash
deps-gradle-update:
	curl -sL https://raw.githubusercontent.com/jesperancinha/project-signer/master/gradleUpdatesOne.sh | bash
deps-quick-update: deps-plugins-update deps-java-update deps-gradle-update
