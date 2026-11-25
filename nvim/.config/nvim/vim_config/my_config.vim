" =====================================================
"  LEADER TUŞU (EN ÜSTTE OLMALI)
" =====================================================
" Leader = Boşluk tuşu.
" Aşağıdaki <leader> geçen her kısayol "Boşluk + tuş" anlamına gelir.
" Bu satır, leader kullanan kısayollardan ÖNCE yazılmalı.
let mapleader = " "

" =====================================================
"  TEMEL AYARLAR
" =====================================================
filetype plugin indent on   " Dosya türüne göre eklenti ve girinti kurallarını aç
syntax on                   " Sözdizimi renklendirmesini aç

set autoindent              " Yeni satır, önceki satırın girintisiyle başlasın
set smartindent             " Kod yapısına göre akıllı girinti (süslü parantez vb.)
set expandtab               " Tab tuşu TAB karakteri yerine boşluk koysun
set tabstop=4               " Bir TAB karakteri ekranda 4 boşluk genişliğinde görünsün
set shiftwidth=4            " >> ve << ile girintileme 4 boşluk olsun
set softtabstop=4           " Tab/Backspace 4 boşluk adımıyla çalışsın

" Hybrid satır numaraları:
" Mevcut satırda gerçek numara, diğer satırlarda mevcut satıra uzaklık görünür
set number                  " Satır numaralarını göster
set relativenumber          " Diğer satırlar için göreli (uzaklık) numara

set ignorecase              " Aramada büyük/küçük harf farkını yoksay
set smartcase               " Ama aramada büyük harf yazarsan farkı dikkate al
set incsearch               " Yazdıkça arama sonucunu anında göster
set hlsearch                " Arama sonuçlarını vurgula

set scrolloff=8             " İmleç alttan/üstten 8 satır kala kaydırma başlasın
set sidescrolloff=8         " Aynısı yatayda, 8 karakter
set cursorline              " İmlecin bulunduğu satırı vurgula
" set cursorcolumn          " İmlecin sütununu vurgular, göz yorduğu için kapalı

set nowrap                  " Uzun satırlar alt satıra kaydırılmasın (kod düzeni bozulmasın)

" =====================================================
"  YEDEKLEME VE GERİ ALMA (UNDO)
" =====================================================
set nobackup                " Kaydederken yedek dosya (~) oluşturma
set nowritebackup           " Yazma sırasında geçici yedek de oluşturma
set swapfile                " Çökme durumunda kurtarma için swap dosyası kullan

" Geri alma geçmişi dosyayı kapatsan bile saklansın.
" Klasörün var olması gerekir: mkdir -p ~/.local/share/nvim/undo
set undofile                " Undo geçmişini diske kaydet
set undodir=$HOME/.local/share/nvim/undo
set undolevels=1000         " En fazla 1000 geri alma adımı

set mouse=a                 " Fareyi her modda kullanabil
set showcmd                 " Yazdığın tuş komutunu sağ altta göster
set showmode                " Alt satırda mevcut modu göster (INSERT vb.)
set laststatus=2            " Alttaki durum çubuğu her zaman görünsün
set ruler                   " İmlecin satır/sütun konumunu göster

" =====================================================
"  RENK VE GÖRÜNÜM
" =====================================================
" Terminal 24-bit renk destekliyorsa gerçek renkleri aç (tmux içinde değilsek)
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" gruvbox yüklüyse temayı aç, yüklü değilse hata verme (silent!)
silent! colorscheme gruvbox
set background=dark         " Koyu tema

" =====================================================
"  PERFORMANS
" =====================================================
set lazyredraw              " Makro çalışırken ekranı her adımda yenileme
set history=1000            " Komut geçmişinde 1000 komut sakla

" =====================================================
"  SİLME KOPYAYI BOZMASIN
" =====================================================
" HATIRLATICI NOT:
"   y            -> kopyalar
"   d, c, x      -> sadece SİLER, kopyaladığın şey bozulmaz
"   Boşluk + d   -> gerçekten KESER (silineni yapıştırılabilir yapar)
"                   Satır kesmek:  Boşluk, d, d
"                   Kelime kesmek: Boşluk, d, w
"   p            -> yapıştırır
"   "0p          -> en son y ile kopyaladığını yapıştırır (yedek yol)
"   :reg         -> tüm registerları (kopya kayıtlarını) listeler
"   Görsel modda p -> seçili metnin üstüne yapıştırır, kopya bozulmaz
"
" Nasıl çalışıyor: "_ "kara delik" registeridir. Oraya giden şey
" hiçbir yere kaydedilmez, bu yüzden panon/kopyan bozulmaz.
nnoremap d "_d
vnoremap d "_d
nnoremap c "_c
vnoremap c "_c
nnoremap x "_x
vnoremap x "_x

" Boşluk + d : normal d gibi davranır (keser, register'a kaydeder)
nnoremap <leader>d d
vnoremap <leader>d d

" Görsel modda bir şeyin üstüne yapıştırırken, üzerine yazılan metin
" kopyanı bozmasın
xnoremap p "_dP

" İstersen aç: vim'in kopyaları sistem panosuyla ortak kullanması
" (Wayland'de wl-clipboard kurulu olmalı). Açarsan Boşluk+d ile kestiğin
" şey de sistem panosuna gider.
" set clipboard=unnamedplus

" =====================================================
"  ÖZEL KISAYOLLAR (KEYMAPS)
" =====================================================
" Ö tuşu: bir alt satırda boş satır aç ve en son kopyalananı yapıştır
nnoremap ö o<Esc>p

" Görsel modda girintilerken (< ve >) seçim kaybolmasın,
" arka arkaya girintilemeye devam edebil
vnoremap < <gv
vnoremap > >gv

" =====================================================
"  OTOMASYONLAR
" =====================================================
" Dosyayı açtığında imleci en son kaldığın konuma getir
augroup vimrc-remember-cursor
  autocmd!                
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \    exe "normal! g`\"" |
        \ endif
augroup END
