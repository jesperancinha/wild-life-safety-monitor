#!/usr/bin/env bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Add this to you init scrip (.zshrc, .bashrc)"
echo "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "NOTE: k9s may crash while connected to a cluster and that cluster gets removed while k9s is on"
brew install derailed/k9s/k9s
