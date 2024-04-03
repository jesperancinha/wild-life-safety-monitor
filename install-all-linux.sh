#!/usr/bin/env bash
sudo npm install -g @angular/cli
# shellcheck disable=SC2046
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
sudo apt-mark hold kubelet kubeadm kubectl helm
cd ~ || exit;
curl -L https://kuma.io/installer.sh | VERSION=2.6.1 sh -
echo "---------------------------------------------------------------------------"
echo "Don't forget to add the Kuma folder at cd ~/kuma-<version>/bin; to the PATH"
echo "Example:"
echo "cd ~/kuma-2.6.1/bin;"
echo "export PATH=$(pwd):$PATH;"
echo "cd ~"