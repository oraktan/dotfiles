#!/usr/bin/env bash
set -e
sudo dnf install -y unzip >/dev/null 2>&1 || true
mkdir -p ~/.local/share/fonts && cd /tmp
[ -d ~/.local/share/fonts/NerdSymbols ] || { curl -sfLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip && unzip -oq NerdFontsSymbolsOnly.zip -d ~/.local/share/fonts/NerdSymbols; }
[ -d ~/.local/share/fonts/JetBrainsMonoNF ] || { curl -sfLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip && unzip -oq JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNF; }
fc-cache -f
