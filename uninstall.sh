#!/bin/bash

# ============================================================================
# DOTFILES UNINSTALLATION SCRIPT
# ============================================================================

set -e

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║         DOTFILES REMOVAL - RESTORING ORIGINALS            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Find latest backup
BACKUP_DIR=$(ls -td $HOME/dotfiles_backup_* 2>/dev/null | head -1)

if [ -z "$BACKUP_DIR" ]; then
    echo "⚠ No backup found. Removing symlinks only..."
    echo ""
    
    # Remove symlinks
    if [ -L "$HOME/.zshrc" ]; then
        rm "$HOME/.zshrc"
        echo "✓ Removed .zshrc symlink"
    fi
    
    if [ -L "$HOME/.bashrc" ]; then
        rm "$HOME/.bashrc"
        echo "✓ Removed .bashrc symlink"
    fi
    
    if [ -L "$HOME/.vimrc" ]; then
        rm "$HOME/.vimrc"
        echo "✓ Removed .vimrc symlink"
    fi
    
    if [ -L "$HOME/.gitconfig" ]; then
        rm "$HOME/.gitconfig"
        echo "✓ Removed .gitconfig symlink"
    fi
    
    if [ -L "$HOME/.vim" ]; then
        rm "$HOME/.vim"
        echo "✓ Removed .vim symlink"
    fi
    
    echo ""
    echo "⚠ Original files not restored (no backup found)"
    echo "  You may need to restore your original dotfiles manually."
    exit 0
fi

echo "Found backup: $BACKUP_DIR"
echo ""

# Restore files
if [ -f "$BACKUP_DIR/.zshrc" ]; then
    rm -f "$HOME/.zshrc"
    mv "$BACKUP_DIR/.zshrc" "$HOME/.zshrc"
    echo "✓ Restored .zshrc"
else
    if [ -L "$HOME/.zshrc" ]; then
        rm "$HOME/.zshrc"
        echo "✓ Removed .zshrc symlink (no backup to restore)"
    fi
fi

if [ -f "$BACKUP_DIR/.bashrc" ]; then
    rm -f "$HOME/.bashrc"
    mv "$BACKUP_DIR/.bashrc" "$HOME/.bashrc"
    echo "✓ Restored .bashrc"
else
    if [ -L "$HOME/.bashrc" ]; then
        rm "$HOME/.bashrc"
        echo "✓ Removed .bashrc symlink (no backup to restore)"
    fi
fi

if [ -f "$BACKUP_DIR/.vimrc" ]; then
    rm -f "$HOME/.vimrc"
    mv "$BACKUP_DIR/.vimrc" "$HOME/.vimrc"
    echo "✓ Restored .vimrc"
else
    if [ -L "$HOME/.vimrc" ]; then
        rm "$HOME/.vimrc"
        echo "✓ Removed .vimrc symlink (no backup to restore)"
    fi
fi

if [ -f "$BACKUP_DIR/.gitconfig" ]; then
    rm -f "$HOME/.gitconfig"
    mv "$BACKUP_DIR/.gitconfig" "$HOME/.gitconfig"
    echo "✓ Restored .gitconfig"
else
    if [ -L "$HOME/.gitconfig" ]; then
        rm "$HOME/.gitconfig"
        echo "✓ Removed .gitconfig symlink (no backup to restore)"
    fi
fi

if [ -d "$BACKUP_DIR/.vim" ]; then
    rm -rf "$HOME/.vim"
    mv "$BACKUP_DIR/.vim" "$HOME/.vim"
    echo "✓ Restored .vim directory"
else
    if [ -L "$HOME/.vim" ]; then
        rm "$HOME/.vim"
        echo "✓ Removed .vim symlink (no backup to restore)"
    fi
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║              REMOVAL COMPLETE!                            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "Original files restored from: $BACKUP_DIR"
echo ""
echo "To apply changes:"
echo "  source ~/.zshrc"
echo "  source ~/.bashrc"
echo ""
echo "Note: Backup directory will remain at $BACKUP_DIR"
echo "      You can delete it manually if desired."
echo ""

