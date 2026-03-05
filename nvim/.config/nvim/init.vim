
call plug#begin('~/.local/share/nvim/plugged')

" Temalar ve Görünüm
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'nvim-tree/nvim-web-devicons'  " Dosya ikonları için şart
Plug 'itchyny/lightline.vim'        " Mevcut eklentin
" Araçlar
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'    " <- Tırnakların böyle olduğundan emin ol
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" FZF (Fedora'da 'sudo dnf install fzf' yaptıysan en temizi budur)
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()


autocmd vimenter * colorscheme gruvbox
set background=dark


set clipboard=unnamedplus
set number          " Satır numaralarını göster
set relativenumber  " Hızlı atlamak için göreceli numaralar
set termguicolors   " Modern renk desteği

" --- Konfigürasyonları Yükle ---
" Klasör adını 'vim_config' (noktasız) yapmanı öneririm
source ~/.config/nvim/vim_config/alias.vim
source ~/.config/nvim/vim_config/my_config.vim
source ~/.config/nvim/vim_config/plugins_config.vim

" --- Otomasyonlar ---
" Dosya açıldığında imleci son konuma getir
augroup remember_cursor
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

