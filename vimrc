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
" Nexus - Needed for Kweasy
Bundle 'dahu/Nexus'
" Kweasy
Bundle 'dahu/vim-KWEasy'
"------------SYNTAX
" Nagios Syntax
Bundle 'vim-scripts/nagios-syntax'
" Nginx Syntax
Bundle 'nginx.vim'
" Puppet Syntax etc
Bundle 'markeganfuller/vim-puppet'
" Wiki Syntax
Bundle 'wikipedia.vim'
" Salt SLS Syntax
Bundle 'saltstack/salt-vim'
" TWiki Syntax
Bundle 'vim-scripts/TWiki-Syntax'
"------------COLOURSCHEME
" Apprentice Colorscheme
Bundle 'romainl/apprentice'
" Sorcerer Colorscheme
Bundle 'vim-scripts/Sorcerer'
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
        "colorscheme sorcerer
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
highlight LineNr ctermbg=None guibg=None
highlight SignColumn ctermbg=None guibg=None
highlight CursorLine ctermbg=236 ctermfg=None guibg=None
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

" Turn tabs into spaces(4)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround " Round > indents to sw

" Use Bash Higlighting not sh
let g:is_bash = 1

" Use Ruby highlighting for Vagrantfiles
au BufRead,BufNewFile Vagrantfile set filetype=ruby

" Use markdown for .md
au BufRead,BufNewFile *.md set filetype=markdown

" Use sh for audit(d).rules
au BufRead,BufNewFile audit.rules set filetype=sh
au BufRead,BufNewFile auditd.rules set filetype=sh

" Use yaml for eyaml files
au BufRead,BufNewFile *.eyaml set filetype=yaml
au BufRead,BufNewFile eyaml_edit* set filetype=yaml

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

"---------------------------------
" Keybindings
"---------------------------------
" Map Leader
" mapped to , \ and <Space>
let mapleader = ","
let g:mapleader = ","
nmap \ ,
nmap <Space>  ,

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
map <Leader>lb <Esc>:ls<CR>

" Switch Buffer
map <Leader>sb <Esc>:ls<CR>:b<Space>
"
" Vert Split Buffer
map <Leader>vb <Esc>:ls<CR>:vert sb<Space>

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

" Turn plaintext value into eyaml TODO make it work for lines without :
map <Leader>te :norm f:wiDEC::PKCS7[<ESC>Ea]!<ESC><CR>

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
