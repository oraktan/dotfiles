#!/usr/bin/env bash
set -euo pipefail

echo "=== Neovim eklentileri kuruluyor ==="

sudo dnf install -y neovim git curl fzf

mkdir -p "$HOME/.local/share/nvim/site/autoload"

curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim --headless '+PlugInstall --sync' '+qa'

echo "=== Neovim eklentileri kuruldu ==="
