" write all config settings here


"colorscheme desert 


" --- Temel Ayarlar ---

set nocompatible         " Vim'in Vi uyumluluk modunu kapatır. Pluginler için gerekli.
filetype plugin indent on " Dosya türüne göre eklentileri, indent ve dosya türü algılamayı etkinleştirir.

syntax on                " Sözdizimi vurgulamayı (syntax highlighting) etkinleştirir.

set autoindent           " Otomatik girinti (indent) ekler.
set smartindent          " Daha akıllı girintileme yapar (örn: {} sonrası otomatik girinti).
set expandtab            " Tab tuşuna basıldığında boşluk kullanır.
set tabstop=4            " Tab karakterinin genişliğini 4 boşluk yapar.
set shiftwidth=4         " Otomatik girintileme için 4 boşluk kullanır (örn: << veya >>).
set softtabstop=4        " Backspace ve Tab tuşlarının 4 boşluk gibi davranmasını sağlar.

set relativenumber       " Göreceli satır numaralarını gösterir (imlecin olduğu satır 0, üstü 1, 2..., altı 1, 2...).
set number               " Mutlak satır numaralarını gösterir (isteğe bağlı, relativenumber ile çakışabilir).
                         " Genellikle ikisinden biri kullanılır. relativenumber daha pratiktir.

set ignorecase           " Arama yaparken büyük/küçük harf duyarsızlığını açar.
set smartcase            " Eğer arama deseninde büyük harf varsa, büyük/küçük harf duyarlılığını tekrar açar.

set incsearch            " Yazdıkça arama yapar (incremental search).
set hlsearch             " Arama sonuçlarını vurgular.

set scrolloff=8          " İmlecin ekranın üstünden/altından 8 satır uzakta kalmasını sağlar.
set sidescrolloff=8      " İmlecin ekranın solundan/sağından 8 karakter uzakta kalmasını sağlar.

set cursorline           " İmlecin bulunduğu satırı vurgular.
set cursorcolumn         " İmlecin bulunduğu sütunu vurgular (çoğu kişi kullanmaz, göz yorabilir).

set wrap                 " Uzun satırları otomatik olarak sarar (word wrap).
set nowrap               " Uzun satırları sarmaz, yatay kaydırma çubuğu oluşur. (Tercihe bağlı)

set nobackup             " Yedekleme dosyalarını oluşturmaz.
set nowritebackup        " Yazma sırasında yedekleme dosyası oluşturmaz.
set swapfile             " Takas dosyası oluşturur (çökme durumunda kurtarma için iyidir).
" set noswapfile         " Takas dosyası oluşturmaz (disk aktivitesini azaltır, çökme koruması olmaz). (Tercihe bağlı)

set undolevels=1000      " Geri alma geçmişinde tutulacak değişiklik sayısını artırır.
set undofile             " Geri alma geçmişini dosya kapandıktan sonra da korur (persistent undo).
set undodir=~/.vim/undo  " Geri alma dosyalarının saklanacağı dizin (önce oluşturmalısınız: mkdir -p ~/.vim/undo)

set mouse=a              " Fare desteğini tüm modlarda etkinleştirir.

set showcmd              " Kısmi komutları ve tamamlanmamış eşlemeleri ekranın altında gösterir.
set showmode             " Hangi modda olduğunuzu gösterir (INSERT, VISUAL vb.).

set laststatus=2         " Her zaman bir durum çubuğu gösterir (status line).
set ruler                " İmlecin satır ve sütun numarasını durum çubuğunda gösterir.

set visualbell           " Hatalarda görsel uyarı (flash) verir, sesli uyarıyı kapatır.
" set noerrorbells         " Tüm uyarı seslerini kapatır.

" --- Renk ve Görünüm Ayarları ---

set termguicolors        " Terminalin gerçek renk (24-bit) desteğini etkinleştirir (çok önemlidir!).
                         " Eğer terminaliniz 24-bit renkleri desteklemiyorsa sorun çıkarabilir.

" Renk şeması (bir tane seçin ve yorum satırından çıkarın)
colorscheme gruvbox
" colorscheme onedark
" colorscheme dracula
" colorscheme solarized

" --- Performans Ayarları ---

set lazyredraw           " Ekran güncellemelerini yavaşlatır (özellikle büyük dosyalarda hız artırabilir).

" --- Arama ve Kaydırma Ayarları ---

set display=truncate     " Satırlar ekrana sığmazsa sonuna '@' yerine '$' koyar.

" --- Eklenti Ayarları (Opsiyonel, kullandığınız eklentiye göre) ---

" Vim-Plug ayarları
" call plug#begin('~/.vim/plugged')
" Plug 'tpope/vim-fugitive'
" Plug 'preservim/nerdtree'
" Plug 'joshdick/onedark.vim'
" call plug#end()

" NERDTree kısayolu (eğer kuruluysa)
" map <C-n> :NERDTreeToggle<CR>

" --- Diğer Faydalı Eşlemeler (Maps) ---

" W tuşuyla kaydet ve çık
" map <leader>w :w<CR>

" Q tuşuyla çık (kaydetmeden)
" map <leader>q :q<CR>

" Normal modda 'leader' tuşu ile hızlı dosya kaydetme
" Bu genellikle Space veya , olarak ayarlanır. (örn: let mapleader = " ")
" nnoremap <leader>w :w<CR>

" Normal modda 'leader' tuşu ile hızlı çıkış (kaydetmeden)
" nnoremap <leader>q :q<CR>

" Normal modda 'leader' tuşu ile hızlı kaydet ve çık
" nnoremap <leader>wq :wq<CR>

" Yükseltilmiş komut satırı geçmişi
set history=1000

" Geçerli çalışma dizinini otomatik olarak algıla
set autochdir

" Açılışta dosya gezgini (örn. NERDTree) açmak için (isteğe bağlı)
" autocmd VimEnter * NERDTree

" Görsel modda indenting (tab ile)
" vnoremap < <gv
" vnoremap > >gv


"" Dosya açıldığında imleci son konumda başlat
" Dosya açıldığında imleci son konuma getir
augroup vimrc-remember-cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
" ö tuşuna basınca bir alt satıra yapıştır
nnoremap ö o<Esc>p
