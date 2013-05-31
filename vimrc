set nocompatible "Turn off compatiblity mode
syntax on "Turn syntax highlighting on
"Turn Filetype off until plugins have been loaded
filetype off 

" Setup Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
Bundle 'gmarik/vundle'
"---------------------------------
"Bundles
"---------------------------------
"NERDTree File Browser
Bundle 'scrooloose/nerdtree'
 "Tab Mode
Bundle 'jistr/vim-nerdtree-tabs'
"Better % matching
Bundle 'matchit.zip'
" Tabuliser for => in puppet etc
Bundle 'godlygeek/tabular'
"Gist Integration
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
"Git Commands
Bundle 'tpope/vim-fugitive.git'
"Git Diff in Gutter
Bundle 'airblade/vim-gitgutter'
"Python Indentation
Bundle 'klen/python-mode'
"Auto Close HTML
Bundle 'HTML-AutoCloseTag'
"Better Line Number Handling
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
"Collab Editing
Bundle 'FredKSchott/CoVim'
"------------SYNTAX
"Nagios Syntax
Bundle 'vim-scripts/nagios-syntax'
"Nginx Syntax
Bundle 'nginx.vim'
"Puppet Syntax etc
Bundle 'markeganfuller/vim-puppet'
"Wiki Syntax
Bundle 'wikipedia.vim'
"------------COLOURSCHEME
"Monokai Colorscheme
Bundle 'sickill/vim-monokai'
"---------------------------------

" Colour Scheme Setup
try
    set t_Co=256
    colorscheme Monokai
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme pablo
endtry

" Set Shell
set shell=bash

" Set history to a big number
set history=700
" Auto read a file when its changed
set autoread

" Enable filetype plugins
filetype plugin indent on

" UTF-8 !
set encoding=utf-8
set fileencoding=utf-8

set vb "Visual Bell only
set autoread " watch for file changes
" Show Mode and Command in bar
set showmode
set showcmd

" Search as you type
set incsearch

"Turn tabs into spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set autoindent "Follow last lines indent
set nosmartindent "Not Smart, it unindents comments if set

set wrapscan "Wrap searches

set ruler
set scrolloff=8 "Keep 8 lines either way
set relativenumber "Turn line numbers on
set cursorline "Highlight current line

syntax on "Turn syntax highlighting on

" Store swap files in fixed location, not current directory.
if !isdirectory($HOME . "/.vimswap")
    call mkdir($HOME . "/.vimswap")
endif
set dir=~/.vimswap//

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Delete trailing white space on save
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" Set splits to appear below or right
set splitbelow
set splitright

" Set title of term window
set title

" Set Status Line
set laststatus=2
set statusline=%{$USER}@%{hostname()}\ %F\ [%{&syntax}]%r%m%=\|%c,\ %l\|\ %L

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
" Plugin Settings
"---------------------------------
" -Gist
" --Use Private Gists
let g:gist_post_private = 1
let g:gist_show_privates = 1

" -Python Mode
let g:pymode_folding = 0

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
