# =====================================================
# 1. FASTFETCH (Açılış Görseli)
# =====================================================
# Instant Prompt uyarısı almamak için p10k'dan önce çalıştırıyoruz.
if [[ -f "$HOME/.config/fastfetch/config-compact.jsonc" ]]; then
    fastfetch \
      -c "$HOME/.config/fastfetch/config-compact.jsonc" \
      --logo "$HOME/.config/fastfetch/fedora.png" \
      --logo-width 22 \
      --logo-height 12
fi

# =====================================================
# 2. POWERLEVEL10K INSTANT PROMPT
# =====================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =====================================================
# 3. ORTAM DEĞİŞKENLERİ
# =====================================================
export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$HOME/dotfiles/oh-my-zsh/.config/oh-my-zsh"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# =====================================================
# 4. OH MY ZSH AYARLARI
# =====================================================
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  dnf
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
)

# Oh My Zsh yükleniyor
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# =====================================================
# 5. POWERLEVEL10K CONFIG
# =====================================================
[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

# =====================================================
# 6. ARAÇLAR & EKLENTİLER
# =====================================================
# ZOXIDE init
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# =====================================================
# 7. ALIASLAR
# =====================================================
[[ -f "$ZDOTDIR/.alias" ]] && source "$ZDOTDIR/.alias"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat'

# =====================================================
# 8. ZSH SEÇENEKLERİ
# =====================================================
setopt appendhistory
DISABLE_AUTO_TITLE="true"
