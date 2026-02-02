
" Temel Vim ayarlarını yükle (Eğer init.vim içinde değilse)
source ~/.config/nvim/.vimrc

" .vim_config klasöründeki alt dosyaları yeni yollarıyla yükle
source ~/.config/nvim/.vim_config/alias.vim
source ~/.config/nvim/.vim_config/my_config.vim
source ~/.config/nvim/.vim_config/plugins_config.vim
" Eklenti (Plugin) yolunu Neovim'e tanıt
set runtimepath+=~/.config/nvim/.vim
set clipboard=unnamedplus


" Dosya açıldığında imleci son konuma getir
augroup vimrc-remember-cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
