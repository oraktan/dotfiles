# --- 1. P10K INSTANT PROMPT ---
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 2. YOLLAR VE DEĞİŞKENLER ---
export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$HOME/.oh-my-zsh"
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# --- 3. POWERLEVEL10K & TEMA ---
[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# --- 4. OH MY ZSH AYARLARI ---
plugins=(git dnf zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
source $ZSH/oh-my-zsh.sh

# --- 5. EKLENTİLER & ARAÇLAR ---
# FZF (CTRL+R vb. için)
source <(fzf --zsh)

# Zoxide (Hızlı dizin geçişi)
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# --- 6. ALIASLAR (lsd ve diğerleri) ---
[[ -f $ZDOTDIR/.alias ]] && source $ZDOTDIR/.alias
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat' # Eğer 'bat' kuruluysa çok iyidir

# --- 7. GÖRSEL BAŞLANGIÇ (Terminal açıldığında) ---
# Pokemon scriptini istersen buraya ekleyebilirsin:
# pokemon-colorscripts --no-title -s -r
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# --- 8. DİĞER AYARLAR ---
setopt appendhistory
DISABLE_AUTO_TITLE="true"

