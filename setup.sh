#!/bin/bash

set -e

# Function to detect the package manager
detect_package_manager() {
    if command -v apt-get &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v brew &> /dev/null; then
        echo "brew"
    else
        echo "Unknown package manager. Please install manually." >&2
        exit 1
    fi
}

# Detect the package manager
PKG_MANAGER=$(detect_package_manager)

# Update package lists
case $PKG_MANAGER in
    apt)
        sudo apt-get update
        ;;
    dnf|yum)
        sudo $PKG_MANAGER check-update
        ;;
    brew)
        brew update
        ;;
esac

# Install Vim
echo "Installing Vim..."
case $PKG_MANAGER in
    apt)
        sudo apt-get install -y vim
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y vim
        ;;
    brew)
        brew install vim
        ;;
esac

# Install Neovim
echo "Installing Neovim..."
case $PKG_MANAGER in
    apt)
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
        sudo rm -rf /opt/nvim
        sudo tar -C /opt -xzf nvim-linux64.tar.gz
        rm nvim-linux64.tar.gz
        echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc
        echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.zshrc
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y neovim
        ;;
    brew)
        brew install neovim
        ;;
esac

# Install ripgrep
echo "Installing ripgrep..."
case $PKG_MANAGER in
    apt)
        sudo apt-get install -y ripgrep
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y ripgrep
        ;;
    brew)
        brew install ripgrep
        ;;
esac

# Install Zsh
echo "Installing Zsh..."
case $PKG_MANAGER in
    apt)
        sudo apt-get install -y zsh
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y zsh
        ;;
    brew)
        brew install zsh
        ;;
esac

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installation complete!"
