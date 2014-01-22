set nocompatible  " Turn off compatiblity mode
filetype off      " Turn Filetype off until plugins have been loaded

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
" Buffer Line
Bundle 'bling/vim-bufferline'
" CTRL P
Bundle 'kien/ctrlp.vim'
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
" Sorcerer Colorscheme
Bundle 'vim-scripts/Sorcerer'
"---------------------------------
" Colour Scheme Setup
"---------------------------------
" If its a not a tty1-7 term and
" a preferred cs is installed use it
" Else use pablo
if $TERM != 'linux'
    try
        set t_Co=256
        "colorscheme Monokai
        colorscheme sorcerer
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme pablo
        set bg=dark
    endtry
else
    colorscheme pablo
endif

syntax on " Turn syntax highlighting on

" Set line number and sign coloum to have normal bg
highlight LineNr ctermbg=None guibg=None
highlight SignColumn ctermbg=None guibg=None
highlight CursorLine ctermfg=None guibg=None
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
filetype plugin indent on " Enable filetype plugins
set vb " Visual Bell only
set modelines=5 " Fixes OSX not reading modelines
set backspace=2 " Improve backspace

set autoindent " Follow last lines indent
set nosmartindent " Not Smart

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

"---------------------------------
" File Settings
"---------------------------------
set encoding=utf-8 " UTF-8
set fileencoding=utf-8 " UTF-8

" Disable two spaces after .
set nojoinspaces

" Turn tabs into spaces(4)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround " Round > indents to sw

" Use Bash Higlighting not sh
let g:is_bash = 1

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
" --Disable Pymode Help
let g:pymode_doc = 0


" --Skip Some checks
" ---W0621 Redefining name from outer scope
" ---C0301 Line length from pylint (covered by pep8)
" ---C0121 __version__ required in every module (file)
let g:pymode_lint_ignore = "W0621,C0301,C0121"

" -*ML Autoclose Tags
au FileType xhtml,xml,tpl so ~/.vim/bundle/HTML-AutoCloseTag/ftplugin/html_autoclosetag.vim


"---------------------------------
" Keybindings
"---------------------------------
" Map Leader to two keys
let mapleader = ","
let g:mapleader = ","
nmap \ ,

" List Buffers
map <Leader>ll :ls<CR>

":ccl quickfix list
map <Leader>qf :ccl<CR>

" Better window resizing
" - Height
map <Leader>= :resize +5<CR>
map <Leader>- :resize -5<CR>
" - Width (Shift)
map <Leader>+ :vertical resize +5<CR>
map <Leader>_ :vertical resize -5<CR>

" Split Buffer
map <Leader>ss <Esc>:sb<space>

" List Buffers
map <Leader>ls <Esc>:ls<CR>

" Buffer Hotkeys
" Needed to stop vim help
nmap <F1> :b1<CR>

map <F1> :b1<CR>
map <F2> :b2<CR>
map <F3> :b3<CR>
map <F4> :b4<CR>
map <F5> :b5<CR>
map <F6> :b6<CR>
map <F7> :b7<CR>
map <F8> :b8<CR>
map <F9> :b9<CR>
map <F10> :b10<CR>

" And for insert mode
imap <F1> <Esc> :b1<CR>
imap <F2> <Esc> :b2<CR>
imap <F3> <Esc> :b3<CR>
imap <F4> <Esc> :b4<CR>
imap <F5> <Esc> :b5<CR>
imap <F6> <Esc> :b6<CR>
imap <F7> <Esc> :b7<CR>
imap <F8> <Esc> :b8<CR>
imap <F9> <Esc> :b9<CR>
imap <F10> <Esc> :b10<CR>

" Tab Hotkeys
map <Leader><F1> :tab 1<CR>
map <Leader><F2> :tab 2<CR>
map <Leader><F3> :tab 3<CR>
map <Leader><F4> :tab 4<CR>
map <Leader><F5> :tab 5<CR>
map <Leader><F6> :tab 6<CR>
map <Leader><F7> :tab 7<CR>
map <Leader><F8> :tab 8<CR>
map <Leader><F9> :tab 9<CR>
map <Leader><F10> :tab 10<CR>

" And for insert mode
imap <Leader><F1> <Esc> :tab 1<CR>
imap <Leader><F2> <Esc> :tab 2<CR>
imap <Leader><F3> <Esc> :tab 3<CR>
imap <Leader><F4> <Esc> :tab 4<CR>
imap <Leader><F5> <Esc> :tab 5<CR>
imap <Leader><F6> <Esc> :tab 6<CR>
imap <Leader><F7> <Esc> :tab 7<CR>
imap <Leader><F8> <Esc> :tab 8<CR>
imap <Leader><F9> <Esc> :tab 9<CR>
imap <Leader><F10> <Esc> :tab 10<CR>

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
nmap <Leader>ev :tabnew<CR>:cd ~/repos/mine/dotfiles/vimrc<bar>:e vimrc<CR>
nmap <Leader>eb :tabnew<CR>:cd ~/repos/mine/dotfiles/bashrc<bar>:e bashrc<CR>
nmap <Leader>et :e ~/todo.txt<CR>
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
