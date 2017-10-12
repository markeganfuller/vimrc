set nocompatible  " Turn off compatiblity mode
filetype off      " Turn Filetype off until plugins have been loaded

"---------------------------------
" Setup Vundle
"---------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage Vundle
Bundle 'gmarik/Vundle.vim'

"---------------------------------
" Vundle Bundles
"---------------------------------
" Tabuliser for => in puppet etc
Bundle 'godlygeek/tabular'
" Git Commands
Bundle 'tpope/vim-fugitive.git'
" Git Diff in Gutter
Bundle 'airblade/vim-gitgutter'
" Buffer Line
Bundle 'bling/vim-bufferline'
" CTRL P
Bundle 'ctrlpvim/ctrlp.vim'
" Syntastic syntax checking
Bundle 'scrooloose/syntastic'
" Python indentation
Plugin 'hynek/vim-python-pep8-indent'
"------------SYNTAX
" Nagios Syntax
Bundle 'vim-scripts/nagios-syntax'
" Nginx Syntax
Bundle 'nginx.vim'
" Puppet Syntax etc
Bundle 'rodjek/vim-puppet'
" Wiki Syntax
Bundle 'wikipedia.vim'
" Salt SLS Syntax
Bundle 'saltstack/salt-vim'
" TWiki Syntax
Bundle 'vim-scripts/TWiki-Syntax'
"------------COLOURSCHEME
" Apprentice Colorscheme
Bundle 'romainl/apprentice'
"---------------------------------
call vundle#end()
filetype plugin indent on " Enable filetype plugins

" Colour Scheme Setup
"---------------------------------
" If its a not a tty1-7 term and
" a preferred cs is installed use it
" Else use pablo
if $TERM != 'linux'
    try
        set t_Co=256
        colorscheme apprentice
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme pablo
        set bg=dark
    endtry
else
    colorscheme pablo
endif

syntax on " Turn syntax highlighting on

" Set line number and sign coloum to have normal bg
highlight LineNr ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight CursorLine ctermbg=236 ctermfg=NONE guibg=NONE
" Set current line number to have cursor column background
highlight CursorLineNr ctermbg=236

" Status Line
highlight StatusLine ctermfg=16 guifg=#000000
highlight StatusLineNC ctermfg=16 guifg=#000000

" Set Colour for column highlighting
highlight ColorColumn ctermbg=16 guibg=#000000

" Set Highlight for search
highlight Search ctermbg=186 ctermfg=235


"---------------------------------
" Editor Settings
"---------------------------------
set shell=bash " Set Shell
set history=700 " Set history size
set autoread " Auto read a file when its changed
set vb " Visual Bell only
set modelines=5 " Fixes OSX not reading modelines
set backspace=2 " Improve backspace

set undofile " Persistent undo history

" Store undo files in fixed location, not current directory.
if !empty($HOME)
    if !isdirectory($HOME . "/.vimundo")
        call mkdir($HOME . "/.vimundo")
    endif
    set undodir=~/.vimundo
endif

set autoindent " Follow last lines indent
set nosmartindent " Not Smart

set scrolloff=8 " Keep 8 lines either way
set cursorline " Highlight current line
set number " Turn on line numbers
"set relativenumber " Turn on relative line numbers

set incsearch " Search as you type
set hlsearch " Highlight search
set wrapscan " Wrap searches

" Set splits to appear below or right
set splitbelow
set splitright

" Allow buffers to be hidden without saving
set hidden
set switchbuf=useopen,split

" Auto Change CWD to file dir
set autochdir

" Enable Omnicompletion
" <C-x><C-o>
set omnifunc=syntaxcomplete#Complete

set title " Set title of term window

" Show Mode and Command in bar
set showmode
set showcmd

" Set Status Line
set laststatus=2
set statusline=\|\ %c:%l\[%L\][%{&syntax}]%r%m%<%=%{$USER}@%{hostname()}\ %F\ \|

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

" Autoclose Scratch
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Diff Buffer against file
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"---------------------------------
" File Settings
"---------------------------------
set encoding=utf-8 " UTF-8
set fileencoding=utf-8 " UTF-8

" Disable two spaces after .
set nojoinspaces

" Tab / Indent setup
set expandtab "Tab inserts spaces
set shiftround " Round > indents to sw
set softtabstop=4 "Number of spaces that a <Tab> counts for when inserting
set shiftwidth=4 "Indent size for autoindent

" Use Bash Higlighting not sh
let g:is_bash = 1

" Use Ruby highlighting for Vagrantfiles
au BufRead,BufNewFile Vagrantfile set filetype=ruby
" Use 2 space indent for ruby
au FileType ruby setlocal shiftwidth=2 softtabstop=2

" Use markdown for .md
au BufRead,BufNewFile *.md set filetype=markdown

" Use sh for audit(d).rules
au BufRead,BufNewFile audit.rules set filetype=sh
au BufRead,BufNewFile auditd.rules set filetype=sh

" Use yaml for eyaml files
au BufRead,BufNewFile *.eyaml set filetype=yaml
au BufRead,BufNewFile eyaml_edit* set filetype=yaml

" Use twiki for .twiki files
au BufRead,BufNewFile *.twiki set filetype=twiki

" Store swap files in fixed location, not current directory.
if !empty($HOME)
    if !isdirectory($HOME . "/.vimswap")
        call mkdir($HOME . "/.vimswap")
    endif
    set dir=~/.vimswap//
endif

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Delete trailing whitespace on save
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

"---------------------------------
" Plugin Settings
"---------------------------------
let g:syntastic_always_populate_loc_list = 1

"---------------------------------
" Keybindings
"---------------------------------
" Map Leader
" mapped to ,
let mapleader = ","
let g:mapleader = ","

" Toggle location list
map <Leader>loc :lopen<CR>

" Next location
map <Leader>nl :lnext<CR>

" List Buffers
map <Leader>ll :ls<CR>

" Better window resizing
" - Height
map <Leader>= :resize +5<CR>
map <Leader>- :resize -5<CR>
" - Width (Shift)
map <Leader>+ :vertical resize +5<CR>
map <Leader>_ :vertical resize -5<CR>

" Split Buffer
map <Leader>xb <Esc>:sb<space>

" Vert Split Buffer
map <Leader>vb <Esc>:ls<CR>:vert sb<Space>

" List Buffers
map <Leader>ls <Esc>:ls<CR>

" Switch Buffer
map <Leader>sb <Esc>:ls<CR>:b<Space>

" Clear search highlighting
nnoremap <c-l> :noh<CR><c-l>

" Fix *# direction (search for w)
nnoremap # *
nnoremap * #

" Fix CTRL-o/i direction (move in jump list)
nnoremap <C-o> <C-i>
nnoremap <C-i> <C-o>

" Remap [I Show all lines containing string
nmap <Leader>qq [I

" Search in windows
nmap <Leader>qw :windo /<C-r><C-w><CR><Bar><i>

" Edit Various Files
nmap <Leader>ev :e ~/repos/mine/dotfiles/vimrc/vimrc<CR>
nmap <Leader>eb :e ~/repos/mine/dotfiles/bashrc/bashrc<CR>
nmap <Leader>et :e ~/todo.md<CR>
nmap <Leader>es :e ~/scratchpads/

" Reload vimrc
nmap <Leader>lv :so $MYVIMRC<CR>

" Fix Tab Indents (Tab -> 4 Space)
nmap <Leader>ft :%s/\t/    /g<CR>

" Insert a Space
nmap <Leader><Space> :normal i <ESC>

" Colour Columns 80+
nmap <Leader>cc :execute "set colorcolumn=" . join(range(80,335), ',')<CR>
nmap <Leader>nc :set colorcolumn=<CR>

" Show Syntax Element Under Cursor
map <Leader>sn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Insert Python Break Point
map <Leader>xx :normal oimport pdb; pdb.set_trace()  # XXX BREAKPOINT<ESC>
map <Leader>xu :normal oimport pudb; pudb.set_trace()  # XXX BREAKPOINT<ESC>
"-------------------Matching
" Match Tabs and show as errors
map <Leader>mt :match Error /\t/<cr>

" Match Whitespace and show as errors
map <Leader>mw :match Error /\s\+/<cr>

" Clear Matches
map <Leader>mn :match NONE<cr>

" Toggle Spell Checking
map <Leader>sp :setlocal spell!<cr>

" Toggle Paste Mode
map <Leader>pp :setlocal paste!<cr>

" Toggle Line Numbers
"map <Leader>nn :set number! <bar> :set relativenumber!<CR>
map <Leader>nn :set number!<CR>

"-------------------Amazing Transfer
" Transfers line to another vim via a file
" Good for working in multiple terms
" NORMAL MODE (Uses current line)
" Write
nmap <Leader>tw :. w! ~/.vimxfer<CR>
" Read
nmap <Leader>tr :r ~/.vimxfer<CR>
" Append
nmap <Leader>ta :. w! >>~/.vimxfer<CR>

" VISUAL MODE (Uses current selection)
" Write
vmap <Leader>tw :w! ~/.vimxfer<CR>
" Append
vmap <Leader>ta :w! >>~/.vimxfer<CR>
