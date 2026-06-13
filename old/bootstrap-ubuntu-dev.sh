#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "==> Updating Ubuntu package indexes"
sudo apt-get update

echo "==> Upgrading installed packages"
sudo apt-get -y upgrade

echo "==> Installing core development packages"
sudo apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  file \
  gawk \
  git \
  gnupg \
  jq \
  make \
  openssh-client \
  ripgrep \
  unzip \
  wget \
  zip

echo "==> Installing Python helpers"
sudo apt-get install -y \
  python3 \
  python3-pip \
  python3-venv

echo "==> Installing developer QoL tools"
sudo apt-get install -y \
  zsh \
  less \
  tree \
  xz-utils \
  net-tools \
  dnsutils \
  procps

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
touch "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

if ! git config --global user.name >/dev/null 2>&1; then
  echo "==> Git user.name is not set. Configure it manually after script if needed."
fi

if ! git config --global user.email >/dev/null 2>&1; then
  echo "==> Git user.email is not set. Configure it manually after script if needed."
fi

echo "==> Applying recommended Git settings for WSL workflows"
git config --global core.autocrlf input
git config --global core.filemode false
git config --global fetch.prune true
git config --global init.defaultBranch main
git config --global pull.rebase false

mkdir -p "$HOME/src"

cat <<'EOF'

Done.

Next useful steps:

1. Clone repositories into ~/src
2. Open them from WSL with:
   code .
3. If VS Code suggests "Install in WSL" for extensions, accept it for language/runtime extensions.

Optional SSH agent note:
- If you want to use SSH keys from inside WSL, add your keys manually and test with:
  ssh -T git@github.com

EOF
