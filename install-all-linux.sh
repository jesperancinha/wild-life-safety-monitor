#!/usr/bin/env bash
sudo npm install -g @angular/cli
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

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl helm
#sudo apt-mark hold kubelet kubeadm kubectl helm

kumaVersion=$(curl -sL https://api.github.com/repos/kumahq/kuma/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
echo "Installing Kuma version $kumaVersion"
cd ~ || exit;
curl -L https://kuma.io/installer.sh | VERSION="$kumaVersion" sh -
echo "---------------------------------------------------------------------------"
echo "Don't forget to add the Kuma folder at cd ~/kuma-<version>/bin; to the PATH"
echo "---------------------------------------------------------------------------"
echo "Example:"
echo "cd ~/kuma-$kumaVersion/bin;"
echo "export PATH=\$(pwd):\$PATH;"
echo "cd ~"
echo "---------------------------------------------------------------------------"
echo "Which translates to this:"
echo "cd ~/kuma-$kumaVersion/bin;"
echo "export PATH=$(pwd):$PATH;"
echo "cd ~"
echo "---------------------------------------------------------------------------"
