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
" filename:linenumber Handling
Bundle 'bogado/file-line.git'
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
        set bg=dark
    endtry
else
    colorscheme pablo
endif

syntax on " Turn syntax highlighting on

" Set Colour for column highlighting
highlight ColorColumn ctermbg=16 guibg=#000000
" Set Highlight for search
highlight Search ctermbg=Yellow ctermfg=Black

"---------------------------------
" Editor Settings
"---------------------------------
set shell=bash " Set Shell
set history=700 " Set history size
set autoread " Auto read a file when its changed
filetype plugin indent on " Enable filetype plugins
set vb " Visual Bell only
set modelines=5 " Fixes OSX not reading modelines
set backspace=2 " Fix broken backspace

set autoindent " Follow last lines indent
set nosmartindent " Not Smart, it unindents comments if set

set scrolloff=8 " Keep 8 lines either way
set cursorline " Highlight current line
set number " Turn on line numbers
set relativenumber " Turn on relative line numbers

set incsearch " Search as you type
set hlsearch " Highlight search
set wrapscan " Wrap searches

" Set splits to appear below or right
set splitbelow
set splitright

" Allow buffers to be hidden without saving
set hidden
set switchbuf=useopen,split

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

" Use Bash Higlighting not sh
let g:is_bash = 1

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

" Delete trailing whitespace on save
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

"---------------------------------
" Plugin Settings
"---------------------------------
" -Gist
" --Use Private Gists
let g:gist_post_private = 1
let g:gist_show_privates = 1

" --Disable Pymode Folding
let g:pymode_folding = 0
" --Enable Pylint
let g:pymode_lint_checker = "pyflakes,pep8,pylint,mccabe"

" --Skip Some checks
" ---W0621 Redefining name from outer scope
" ---C0301 Line length from pylint (covered by pep8)
let g:pymode_lint_ignore = "W0621,C0301"

" Additional python paths for OSX
if system("uname") == "Darwin\n"
    let g:pymode_paths = ['/usr/local/python2.7/site-packages', '/Library/Python/2.7/site-packages/']
endif

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

" Better window resizing
" - Height
map <Leader>= :resize +5<CR>
map <Leader>- :resize -5<CR>
" - Width (Shift)
map <Leader>+ :vertical resize +5<CR>
map <Leader>_ :vertical resize -5<CR>

" Switch Buffer
map <Leader>ss <Esc>:sb<space>

" List Buffers
map <Leader>ll <Esc>:ls<CR>

" Tab Hotkeys
"Needed to stop vim help
nmap <F1> 1gt

map <F1> 1gt
map <F2> 2gt
map <F3> 3gt
map <F4> 4gt
map <F5> 5gt
map <F6> 6gt
map <F7> 7gt
map <F8> 8gt
map <F9> 9gt
map <F10> 10gt

" And for insert mode
imap <F1> <Esc> 1gt
imap <F2> <Esc> 2gt
imap <F3> <Esc> 3gt
imap <F4> <Esc> 4gt
imap <F5> <Esc> 5gt
imap <F6> <Esc> 6gt
imap <F7> <Esc> 7gt
imap <F8> <Esc> 8gt
imap <F9> <Esc> 9gt
imap <F10> <Esc> 10gt

" Move Tab Hotkeys
map <Leader><F1> :tabm 0<CR>
map <Leader><F2> :tabm 1<CR>
map <Leader><F3> :tabm 2<CR>
map <Leader><F4> :tabm 3<CR>
map <Leader><F5> :tabm 4<CR>
map <Leader><F6> :tabm 5<CR>
map <Leader><F7> :tabm 6<CR>
map <Leader><F8> :tabm 7<CR>
map <Leader><F9> :tabm 8<CR>
map <Leader><F10> :tabm 9<CR>

" And for insert mode
imap <Leader><F1> <Esc> :tabm 0<CR>
imap <Leader><F2> <Esc> :tabm 1<CR>
imap <Leader><F3> <Esc> :tabm 2<CR>
imap <Leader><F4> <Esc> :tabm 3<CR>
imap <Leader><F5> <Esc> :tabm 4<CR>
imap <Leader><F6> <Esc> :tabm 5<CR>
imap <Leader><F7> <Esc> :tabm 6<CR>
imap <Leader><F8> <Esc> :tabm 7<CR>
imap <Leader><F9> <Esc> :tabm 8<CR>
imap <Leader><F10> <Esc> :tabm 9<CR>

" Sessions
map <Leader>sw :mksession! ~/.mysession.vim<CR>
map <Leader>sr :source ~/.mysession.vim<CR>

" Clear search highlighting
nnoremap <c-l> :noh<CR><c-l>

" Fix *# direction (search for w)
nnoremap # *
nnoremap * #

" Fix CTRL-o/i direction (move in jump list)
nnoremap <C-o> <C-i>
nnoremap <C-i> <C-o>

" Remap [I (Search)
nmap <Leader>qq [I

" Search in windows
nmap <Leader>qw :windo /<C-r><C-w><CR><Bar><i>

" Edit Various Files
nmap <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>
nmap <Leader>eb :tabnew<CR>:e ~/.bashrc<CR>
nmap <Leader>et :tabnew<CR>:e ~/todo.txt<CR>
" Reload vimrc
nmap <Leader>lv :so $MYVIMRC<CR>

" Fix Tab Indents (Tab -> 4 Space)
nmap <Leader>ft :%s/\t/    /g<CR>

" Insert a Space
nmap <Leader><Space> :normal i <ESC>

" Colour Columns 80+
nmap <Leader>cc :execute "set colorcolumn=" . join(range(80,335), ',')<CR>
nmap <Leader>nc :set colorcolumn=<CR>


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
map <Leader>nn :set number!<CR> :set relativenumber!<CR>

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

"-------------------NERDTree
map <Leader>tt :NERDTreeTabsToggle<CR>
"-------------------Gitgutter
map <Leader>gg :GitGutterToggle<CR>
