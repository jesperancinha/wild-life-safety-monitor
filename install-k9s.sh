#!/usr/bin/env bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Add this to you init scrip (.zshrc, .bashrc)"
echo "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install derailed/k9s/k9s
