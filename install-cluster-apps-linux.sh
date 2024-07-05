#!/usr/bin/env bash
# shellcheck disable=SC2046
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/latest/download/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

sudo apt-get install -y apt-transport-https ca-certificates curl gpg

k8sVersion=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
k8sVersion=$(echo "$k8sVersion" | awk -F '.' '{print $1 "." $2}')
echo "Installing Kubernetes version $k8sVersion"
curl -fsSL https://pkgs.k8s.io/core:/stable:/"$k8sVersion"/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/'$k8sVersion'/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubectl
