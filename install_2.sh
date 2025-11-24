#!/bin/bash

set -euo pipefail

# Function to install package with progress indicator

install_package() {
  local package=$1
  echo -n "Installing $package...."
  sudo dnf install -y "$package" &>/dev/null &
  local PID=$!

  while kill -0 $PID 2>/dev/null; do
    echo -n "."
    sleep 1
  done
  echo " Done!!"

}

echo "Hello $USER"

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

if [[ $ID == "fedora" ]]; then
  echo "Installing Packages for $ID"
else
  echo "This script runs on Fedora Linux"
  exit 1
fi

#Update system

echo "Updating system....."
sudo dnf update -y &>/dev/null
echo "System updated!"

#Install packages

install_package "git"
install_package "curl"
install_package "wget"
install_package "@development-tools" # development tools for fedora
install_package "android-tools"
install_package "zsh"
install_package "network-server"
install_package "vlc"
install_package "neovim"
install_package "vim"
install_package "cmake"
install_package "nvtop" # GPU Monitor
install_package "htop"
install_package "python3-pip"
install_package "fastfetch"
install_package "loupe"                # Image viewer for gnome desktop environment
install_package "@python3-development" # Python Development tools
install_package "@virtualization"

echo "All Packages installed successfully"

# Installing the nodjs LTS version

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 24

# Verify the Node.js version:
node -v # Should print "v24.11.0".

# Verify npm version:
npm -v # Should print "11.6.1".

if command -v node &>/dev/null && command -v npm &>/dev/null; then
  echo "✓ Node.js is installed (Node: $(node -v), npm: $(npm -v))"
else
  echo "✗ Node.js did not installed"
fi

# Install the rust language

echo "Installing Rust...."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source the environment
source "$HOME/.cargo/env"

# Verify installation
if command -v rustc &>/dev/null && command -v cargo &>/dev/null; then
  echo "✓ Rust is installed ($(rustc --version))"
else
  echo "✗ Rust installation failed"
fi
