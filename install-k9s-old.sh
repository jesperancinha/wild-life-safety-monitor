#!/usr/bin/env bash
# Go to a temporary directory
cd /tmp || exit

# Download the desired version
wget https://github.com/derailed/k9s/releases/download/v0.25.20/k9s_Linux_x86_64.tar.gz

# Extract the downloaded archive
tar -xzvf k9s_Linux_x86_64.tar.gz

# Move the binary to /usr/local/bin
sudo mv k9s /usr/local/bin

# Set execute permissions
sudo chmod +x /usr/local/bin/k9s

# Verify installation
k9s version
