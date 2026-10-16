#!/usr/bin/env bash
C="$HOME/.config/oh-my-zsh/custom"
mkdir -p "$C/plugins" "$C/themes"
clone() { [ -d "$2" ] || git clone --depth=1 "$1" "$2"; }
clone https://github.com/zsh-users/zsh-autosuggestions "$C/plugins/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting "$C/plugins/zsh-syntax-highlighting"
clone https://github.com/zsh-users/zsh-history-substring-search "$C/plugins/zsh-history-substring-search"
clone https://github.com/romkatv/powerlevel10k "$C/themes/powerlevel10k"
