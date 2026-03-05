" --- Temel Ayarlar ---
filetype plugin indent on 
syntax on  

set autoindent          
set smartindent         
set expandtab           
set tabstop=4           
set shiftwidth=4        
set softtabstop=4       

" Hybrid Line Numbers: Mevcut satır gerçek nosunu, diğerleri mesafeyi gösterir
set number              
set relativenumber      

set ignorecase          
set smartcase           
set incsearch           
set hlsearch            

set scrolloff=8         
set sidescrolloff=8     
set cursorline          
" set cursorcolumn      " Çok göz yorduğu için kapalı tutmanı öneririm

set nowrap              " Kodun yapısını bozmaması için satır kaydırmayı kapattık

" --- Yedekleme ve Geri Alma (Undo) ---
set nobackup            
set nowritebackup       
set swapfile            

" Geri alma geçmişini Neovim'in standart data klasörüne kaydet (Daha temiz)
set undofile            
set undodir=$HOME/.local/share/nvim/undo
set undolevels=1000     

set mouse=a             
set showcmd             
set showmode            
set laststatus=2        
set ruler               

" --- Renk ve Görünüm ---
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Eklenti yüklü mü kontrol et, öyleyse temayı aç
silent! colorscheme gruvbox
set background=dark

" --- Performans ---
set lazyredraw          
set history=1000

" --- Özel Kısayollar (Keymaps) ---
" Ö tuşuna basınca bir alt satıra geç ve yapıştır (Pratik!)
nnoremap ö o<Esc>p

" Görsel modda (Visual Mode) girintileme yaparken seçimi kaybetme
vnoremap < <gv
vnoremap > >gv

" --- Otomasyonlar ---
" Dosya açıldığında imleci son konuma getir
augroup vimrc-remember-cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \    exe "normal! g`\"" |
        \ endif
augroup END
