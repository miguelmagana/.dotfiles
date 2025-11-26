#!/bin/bash

# ============================================================================
# DOTFILES INSTALLATION SCRIPT
# ============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║         DOTFILES INSTALLATION - HACKER EDITION            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "✓ Backup directory created: $BACKUP_DIR"
echo ""

# Function to backup and link file
backup_and_link() {
    local file=$1
    local source="$DOTFILES_DIR/$file"
    local target="$HOME/$file"
    
    if [ ! -f "$source" ]; then
        echo "⚠ Warning: Source file $source not found, skipping..."
        return
    fi
    
    if [ -f "$target" ] || [ -L "$target" ]; then
        echo "  Backing up existing $file..."
        mv "$target" "$BACKUP_DIR/$file"
    fi
    
    echo "  Linking $file..."
    ln -sf "$source" "$target"
}

# Install dotfiles
echo "Installing dotfiles..."
backup_and_link ".zshrc"
backup_and_link ".bashrc"
backup_and_link ".vimrc"
backup_and_link ".gitconfig"

# Install vim config (if .vim directory exists in dotfiles)
if [ -d "$DOTFILES_DIR/.vim" ]; then
    if [ -d "$HOME/.vim" ] || [ -L "$HOME/.vim" ]; then
        echo "  Backing up existing .vim..."
        mv "$HOME/.vim" "$BACKUP_DIR/.vim"
    fi
    echo "  Linking .vim directory..."
    ln -sf "$DOTFILES_DIR/.vim" "$HOME/.vim"
fi

echo ""
echo "Checking dependencies..."
echo ""

# Check for Zsh
if ! command -v zsh &> /dev/null; then
    echo "⚠ Zsh not found. Installing..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y zsh
        echo "✓ Zsh installed"
    elif command -v yum &> /dev/null; then
        sudo yum install -y zsh
        echo "✓ Zsh installed"
    else
        echo "⚠ Could not install Zsh automatically. Please install it manually."
    fi
else
    echo "✓ Zsh found ($(which zsh))"
fi

# Check for Zellij
if ! command -v zellij &> /dev/null; then
    echo "⚠ Zellij not found. Installing..."
    ZELLIJ_VERSION=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | grep 'tag_name' | cut -d '"' -f 4 | sed 's/v//')
    if [ -z "$ZELLIJ_VERSION" ]; then
        ZELLIJ_VERSION="0.40.0"  # Fallback version
    fi
    
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            ARCH="x86_64"
            ;;
        aarch64|arm64)
            ARCH="aarch64"
            ;;
        *)
            echo "⚠ Unsupported architecture: $ARCH"
            echo "  Please install Zellij manually from https://github.com/zellij-org/zellij/releases"
            ;;
    esac
    
    if [ "$ARCH" != "unsupported" ]; then
        ZELLIJ_URL="https://github.com/zellij-org/zellij/releases/latest/download/zellij-${ARCH}-unknown-linux-musl.tar.gz"
        echo "  Downloading Zellij from GitHub releases..."
        cd /tmp
        curl -L "$ZELLIJ_URL" -o zellij.tar.gz
        tar -xzf zellij.tar.gz
        sudo mv zellij /usr/local/bin/
        rm zellij.tar.gz
        echo "✓ Zellij installed"
    fi
else
    echo "✓ Zellij found ($(which zellij))"
fi

# Check for neofetch
if ! command -v neofetch &> /dev/null; then
    echo "⚠ Neofetch not found. Installing..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y neofetch
        echo "✓ Neofetch installed"
    elif command -v yum &> /dev/null; then
        sudo yum install -y neofetch
        echo "✓ Neofetch installed"
    else
        echo "⚠ Could not install Neofetch automatically. Please install it manually."
    fi
else
    echo "✓ Neofetch found ($(which neofetch))"
fi

# Set Zsh as default shell (optional)
echo ""
read -p "Set Zsh as default shell? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v zsh &> /dev/null; then
        ZSH_PATH=$(which zsh)
        chsh -s "$ZSH_PATH"
        echo "✓ Zsh set as default shell"
    else
        echo "⚠ Zsh not found, cannot set as default shell"
    fi
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║              INSTALLATION COMPLETE!                       ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "Backup location: $BACKUP_DIR"
echo ""
echo "To apply changes:"
echo "  source ~/.zshrc"
echo ""
echo "Or restart your terminal."
echo ""

