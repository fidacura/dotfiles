" ---------------------------------------------------------
" -----------------------> General <-----------------------
" ---------------------------------------------------------
" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
set hidden

set history=500
filetype plugin on
filetype indent on

"Reload files changed outside vim
set autoread

" Line numbers are useful
set number   

" Map leader for extra key combinations
let mapleader = ","
let maplocalleader = ","
let g:mapleader = ","

" Fast Saving
nmap <leader>w :w!<cr>

" Snippet to handle permission-denied errors
command W w !sudo tee % > /dev/null


" ---------------------------------------------------------
" --------------------> User Interface <-------------------
" ---------------------------------------------------------
set ignorecase
set smartcase
" Highlight searches by default
set hlsearch
" Find the next match as we type the search
set incsearch 
set lazyredraw 
"enable ctrl-n and ctrl-p to scroll thru matches
set wildmenu
set wildmode=list:longest
set ruler
set ttyfast
set cmdheight=2
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Show incomplete commands
set showcmd   

" Show mode down the bottom
set showmode 

" For regular expressions turn magic on
set magic

set showmatch 
set mat=2
set noincsearch

" Extra margin to the left
set foldcolumn=1

"Start scrolling when we're 8 lines away from margins
set scrolloff=8         
set sidescrolloff=15
set sidescroll=1


" ---------------------------------------------------------
" --------------------> Fonts & Colors <-------------------
" ---------------------------------------------------------
set encoding=utf8
syntax enable 
set background=dark

try
    colorscheme Tomorrow-Night-Bright
catch
endtry

if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif


" ---------------------------------------------------------
" -------------------> Files & Backups <-------------------
" ---------------------------------------------------------
" Turn off swap files
set noswapfile
set nobackup
set nowb


" ---------------------------------------------------------
" ---------------------> Indentation <---------------------
" ---------------------------------------------------------
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

" 500 chars line breaker
set lbr
set tw=500

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

"Wrap lines
set wrap 


" ---------------------------------------------------------
" ----------------------> Navigation <---------------------
" ---------------------------------------------------------
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 


" ---------------------------------------------------------
" ---------------------> Status Line <---------------------
" ---------------------------------------------------------
" Always show the status line
set laststatus=2


" ---------------------------------------------------------
" --------------------> Spell Checking <-------------------
" ---------------------------------------------------------
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


" ---------------------------------------------------------
" ----------------------> File Types <---------------------
" ---------------------------------------------------------

" -----------------------> General <-----------------------
"
au FileType php,javascript,html,css,python,vim set ff=unix

" ------------------------> HTML/CSS <----------------------
"
au BufRead,BufNewFile *.css set ft=css syntax=css3

" ---------------------> JavaScript <-----------------------
"
au FileType javascript setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType javascript exe AutoClose()
au FileType javascript exe MatchingQuotes()

" -----------------------> Python <-------------------------
"
set modeline
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

" ---------------------------> Shell <-----------------------
"
au FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
if exists('$TMUX') 
    set term=screen-256color 
endif







