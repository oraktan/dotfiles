" Add here plug and write :PlugInstall 

call plug#begin('~/.vim/plugged')

" Örnek eklentiler:
Plug 'preservim/nerdtree'         " Dosya gezgini
Plug 'tpope/vim-fugitive'         " Git entegrasyonu
Plug 'itchyny/lightline.vim'      " Hafif status bar
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Hızlı arama
Plug 'junegunn/fzf.vim'               " FZF için Vim entegrasyonu
Plug 'jiangmiao/auto-pairs'           " Parantez eşleştirme
Plug 'tpope/vim-commentary'           " Yorum satırı ekleme
Plug 'Yggdroot/indentLine'            " Girinti çizgileri
Plug 'morhetz/gruvbox'

call plug#end()

