set nocompatible " Turn off compatiblity mode
filetype off " Turn Filetype off until plugins have been loaded

"---------------------------------
" Setup Vundle
"---------------------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

"---------------------------------
" Vundle Bundles
"---------------------------------
" NERDTree File Browser
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
" Better % matching
Bundle 'matchit.zip'
" Tabuliser for => in puppet etc
Bundle 'godlygeek/tabular'
" Gist Integration
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
" Git Commands
Bundle 'tpope/vim-fugitive.git'
" Git Diff in Gutter
Bundle 'airblade/vim-gitgutter'
" Python Indentation
Bundle 'klen/python-mode'
" Auto Close HTML
Bundle 'HTML-AutoCloseTag'
" Better Line Number Handling
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
"------------SYNTAX
" Nagios Syntax
Bundle 'vim-scripts/nagios-syntax'
" Nginx Syntax
Bundle 'nginx.vim'
" Puppet Syntax etc
Bundle 'markeganfuller/vim-puppet'
" Wiki Syntax
Bundle 'wikipedia.vim'
"------------COLOURSCHEME
" Monokai Colorscheme
Bundle 'sickill/vim-monokai'

"---------------------------------
" Colour Scheme Setup
"---------------------------------
" If its a not a tty1-7 term and
" Monokai is installed use it
" Else use pablo
if $TERM != 'linux'
    try
        set t_Co=256
        colorscheme Monokai
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme pablo
    endtry
else
    colorscheme pablo
endif

syntax on "Turn syntax highlighting on

" Set Colour for column highlighting
highlight ColorColumn ctermbg=16 guibg=#000000

"---------------------------------
" Editor Settings
"---------------------------------
set shell=bash " Set Shell
set history=700 " Set history size
set autoread " Auto read a file when its changed
filetype plugin indent on " Enable filetype plugins
set vb " Visual Bell only
set modelines=5 "Fixes OSX not reading modelines

set guifont=Courier\ New:h15

set autoindent "Follow last lines indent
set nosmartindent "Not Smart, it unindents comments if set

set scrolloff=8 "Keep 8 lines either way
set cursorline "Highlight current line
set number "Turn on line numbers

set incsearch " Search as you type
set wrapscan "Wrap searches

" Set splits to appear below or right
set splitbelow
set splitright

set title " Set title of term window

" Show Mode and Command in bar
set showmode
set showcmd

" Set Status Line
set laststatus=2
set statusline=\|%c,\ %l\|%=%{$USER}@%{hostname()}\ %F\ [%{&syntax}]%r%m\|\ %L

" Autoclose quickfix if last window
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

"---------------------------------
" File Settings
"---------------------------------
set encoding=utf-8 " UTF-8
set fileencoding=utf-8 " UTF-8

" Turn tabs into spaces(4)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Store swap files in fixed location, not current directory.
if !isdirectory($HOME . "/.vimswap")
    call mkdir($HOME . "/.vimswap")
endif
set dir=~/.vimswap//

set viminfo^=% " Remember info about open buffers on close
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Delete trailing white space on save
" Enabled for .py files
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

"---------------------------------
" Plugin Settings
"---------------------------------
" -Gist
" --Use Private Gists
let g:gist_post_private = 1
let g:gist_show_privates = 1

" -Python Mode
" --Disable Folding
let g:pymode_folding = 0
" --Enable Pylint
let g:pymode_lint_checker = "pyflakes,pep8,pylint,mccabe"

" -*ML Autoclose Tags
au FileType xhtml,xml,tpl so ~/.vim/bundle/HTML-AutoCloseTag/ftplugin/html_autoclosetag.vim

"---------------------------------
" Keybindings
"---------------------------------
" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Edit vimrc
nmap <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>
" Reload vimrc
nmap <Leader>lv :so $MYVIMRC<CR>

" Fix Tab Indents (Tab -> 4 Space)
nmap <Leader>ft :%s/\t/    /g<CR>

" Colour Columns 80+
nmap <Leader>cc :execute "set colorcolumn=" . join(range(80,335), ',')<CR>
nmap <Leader>nc :set colorcolumn=<CR>

"-------------------Amazing Transfer
" Transfers line to another vim via a file
" Good for working in multiple terms
" NORMAL MODE (Uses current line)
" Write
nmap <leader>tw :. w! ~/.vimxfer<CR>
" Read
nmap <leader>tr :r ~/.vimxfer<CR>
" Append
nmap <leader>ta :. w! >>~/.vimxfer<CR>

" VISUAL MODE (Uses current selection)
" Write
vmap <leader>tw :w! ~/.vimxfer<CR>
" Append
vmap <leader>ta :w! >>~/.vimxfer<CR>

"-------------------Matching
" Match Tabs and show as errors
map <leader>mt :match Error /[\t]/<cr>

" Clear Matches
map <leader>mn :match NONE<cr>

" Toggle Spell Checking
map <leader>ss :setlocal spell!<cr>

" Toggle Paste Mode
map <leader>pp :setlocal paste!<cr>

"-------------------NERDTree
nmap <F7> :NERDTreeTabsToggle<CR>
