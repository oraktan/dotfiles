# --- 1. P10K INSTANT PROMPT ---
# Performans için quiet modunda kalması iyidir
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 2. YOLLAR VE DEĞİŞKENLER ---
export ZDOTDIR="$HOME/.config/zsh"
# Eğer stow ile bağladıysan burası standart kalsın, 
# ama dosyalar hala dotfiles içindeyse tam yolu buraya yazabilirsin.
export ZSH="$HOME/dotfiles/oh-my-zsh/.config/oh-my-zsh"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# --- 3. OH MY ZSH AYARLARI ---
# Tema değişkeni burada tanımlanır, altta source edilir
ZSH_THEME="powerlevel10k/powerlevel10k"

# Eklentiler (Custom klasörüne indirdiğin eklentiler burada listelenir)
plugins=(
    git 
    dnf 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    zsh-history-substring-search
)

# Oh My Zsh'i başlat (Bu satır eklentileri ve temayı otomatik yükler)
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
else
    echo "Hata: Oh My Zsh $ZSH dizininde bulunamadı!"
fi

# --- 4. POWERLEVEL10K CONFIG ---
# P10k ayarlarını OMZ yüklendikten sonra yüklemek daha sağlıklıdır
[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh

# --- 5. EKLENTİLER & ARAÇLAR ---
# FZF (Kuruluysa çalıştır)
if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

# Zoxide
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# --- 6. ALIASLAR ---
[[ -f $ZDOTDIR/.alias ]] && source $ZDOTDIR/.alias
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat'




# --- FASTFETCH AYARI ---
if [[ -f "$HOME/.config/fastfetch/config-compact.jsonc" ]]; then
    # --logo-type kitty veya --logo-type chafa ekleyerek görseli zorlayabiliriz
    fastfetch -c "$HOME/.config/fastfetch/config-compact.jsonc" --logo "$HOME/.config/fastfetch/fedora.png" --logo-width 22 --logo-height 12
fi


# --- 8. DİĞER AYARLAR ---
setopt appendhistory
DISABLE_AUTO_TITLE="true"
