#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$HOME/.config"

DIRS=(
    alias
    atuin
    bashrc
    ghostty
    hypr
    networkmanager-dmenu
    not
    nvim
    oh-my-zsh
    rofi
    scripts
    Thunar
    waybar
    yazi
    zsh
)

echo "Removing existing config directories..."

for dir in "${DIRS[@]}"; do
    if [[ -e "$CONFIG_DIR/$dir" ]]; then
        rm -rf "$CONFIG_DIR/$dir"
        echo "✓ Removed $CONFIG_DIR/$dir"
    else
        echo "- Skipped $CONFIG_DIR/$dir (not found)"
    fi
done

echo "Done."
