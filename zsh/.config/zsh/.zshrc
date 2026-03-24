# =====================================================
# 1. POWERLEVEL10K INSTANT PROMPT (En Üstte Kalmalı)
# =====================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =====================================================
# 2. ORTAM DEĞİŞKENLERİ VE YOLLAR
# =====================================================
export ZDOTDIR="$HOME/.config/zsh"
# DİKKAT: Paylaştığın ağaç yapısı tam olarak neredeyse ZSH orayı göstermeli.
# Genelde ~/.config/oh-my-zsh veya ~/.oh-my-zsh olur.
export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export PATH="$HOME/.local/bin:$PATH"

# =====================================================
# 3. OH MY ZSH AYARLARI
# =====================================================
# Tema tanımı source işleminden ÖNCE yapılmalıdır.
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git 
  dnf 
  sudo 
  z 
  extract 
  fzf 
  common-aliases
  zsh-history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Oh My Zsh yükleniyor
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "Hata: Oh My Zsh yolu bulunamadı! Lütfen export ZSH kısmını kontrol et."
fi

# =====================================================
# 4. POWERLEVEL10K VE ARAÇLAR (Source'dan SONRA)
# =====================================================
[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

# ZOXIDE
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# =====================================================
# 5. ALIASLAR VE SEÇENEKLER
# =====================================================
[[ -f "$ZDOTDIR/.alias" ]] && source "$ZDOTDIR/.alias"

# Alias overrides
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat'
# setopt appendhistory
# DISABLE_AUTO_TITLE="true"
#sysinfo_once() {
  add-zsh-hook -d precmd sysinfo_once
  echo
  echo "🖥  $(uname -srmo)"
  echo "🧠 RAM: $(free -h | awk '/Mem:/ {print $3 " / " $2}')"
  echo "⏱  Uptime: $(uptime -p)"
  echo
}
