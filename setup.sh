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

# Install jq
echo "Installing jq..."
case $PKG_MANAGER in
    apt)
        sudo apt-get install -y jq
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y jq
        ;;
    brew)
        brew install jq
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
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"

link_file() {
    local source=$1
    local target=$2

    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source" ]]; then
        return
    fi

    if [[ -e "$target" || -L "$target" ]]; then
        mv "$target" "${target}.${BACKUP_SUFFIX}"
    fi

    ln -s "$source" "$target"
}

echo "Linking dotfiles..."
link_file "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/home/.zprofile" "$HOME/.zprofile"
link_file "$DOTFILES_DIR/home/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/home/.tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/home/.gitignore-global" "$HOME/.gitignore-global"
link_file "$DOTFILES_DIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
link_file "$DOTFILES_DIR/config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
link_file "$DOTFILES_DIR/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
link_file "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"

case "$(uname -s)" in
    Darwin)
        CODE_USER_DIR="$HOME/Library/Application Support/Code/User"
        CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
        ;;
    Linux)
        CODE_USER_DIR="$HOME/.config/Code/User"
        CURSOR_USER_DIR="$HOME/.config/Cursor/User"
        ;;
esac

if [[ -n "${CODE_USER_DIR:-}" ]]; then
    link_file "$DOTFILES_DIR/config/vscode/settings.json" "$CODE_USER_DIR/settings.json"
    link_file "$DOTFILES_DIR/config/vscode/keybindings.json" "$CODE_USER_DIR/keybindings.json"
    link_file "$DOTFILES_DIR/config/cursor/settings.json" "$CURSOR_USER_DIR/settings.json"
    link_file "$DOTFILES_DIR/config/cursor/keybindings.json" "$CURSOR_USER_DIR/keybindings.json"
fi

git config --global core.excludesfile "$HOME/.gitignore-global"

echo "Installation complete!"
