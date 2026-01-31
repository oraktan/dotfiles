

# 1. Hata veren başlık güncellemelerini kapat
DISABLE_AUTO_TITLE="true"

# 2. Yol Tanımlamaları
export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$ZDOTDIR/oh-my-zsh"
[[ -f ~/.config/zsh/.alias ]] && source ~/.config/zsh/.alias
# 3. Powerlevel10k Anlık Prompt (En üstte olması hızı artırır)
[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh

# 4. Oh My Zsh Başlat
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# 5. Tema Yükleme (Klasör yapına göre güncellendi)
[[ -f $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme ]] && source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme

# 6. Eklentiler
#[[ -f $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh ]] && source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
[[ -f $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 7. Zoxide
eval "$(zoxide init zsh)"
