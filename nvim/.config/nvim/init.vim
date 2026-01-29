source ~/.vimrc

" .vim_config klasöründeki alt dosyaları yükle
source ~/.vim_config/alias.vim
source ~/.vim_config/my_config.vim
source ~/.vim_config/plugins_config.vim

" Eklenti (Plugin) yolunu Neovim'e tanıt
set runtimepath+=~/.vim
set clipboard=unnamedplus


" Dosya açıldığında imleci son konuma getir
augroup vimrc-remember-cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
