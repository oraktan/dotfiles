:abbr ilk #!/bin/bash
" ö tuşuna basınca bir alt satıra yapıştır
nnoremap ö o<Esc>p
let mapleader = " "
nnoremap zz $
onoremap zz $
vnoremap zz $
nnoremap <C-h> :%s/
"nnoremap Y y`a
" Y tuşuna basınca: 
" v (görsel modu aç) -> `a (işarete git) -> y (seçili alanı kopyala)
nnoremap Y v`ay
vnoremap Y `ay
onoremap Y `a
" s tuşuna basınca direkt 'a' işaretini koy (ma yerine)
nnoremap s ma
nnoremap <leader>f :echo expand('%:p')<CR>
" Boşluk + h (Help) tuşuna basınca alias dosyasının içeriğini ekrana yazdırır
nnoremap <leader>h :echo join(readfile(expand('~/dotfiles/nvim/.config/nvim/.vim_config/alias.vim')), "\n")<CR>
" Boşluk + w basınca kaydetsin
nnoremap <leader>w :w<CR>

nnoremap <leader>q :q<CR>
" Boşluk + 1 basınca oraya ışınlan (Ters tırnakla uğraşma)
nnoremap <leader>1 `1
nnoremap <leader>2 `2
nnoremap <leader>3 `3
nnoremap <leader>4 `4
nnoremap <leader>5 `5
" Boşluk tuşunu (Leader) ayarla
let mapleader = " "

" İstediğin Telescope kısayolları (Vimscript formatı)
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
