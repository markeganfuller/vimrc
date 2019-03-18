set nocompatible  " Turn off compatiblity mode
filetype off      " Turn Filetype off until plugins have been loaded

"---------------------------------
" Setup Vundle
"---------------------------------
set runtimepath+=~/.vim/bundle/Vundle.vim
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
" ALE syntax checking
Bundle 'w0rp/ale'
" Python indentation
Plugin 'hynek/vim-python-pep8-indent'
" Show registers when accessing
Plugin 'junegunn/vim-peekaboo'
" Comments
Plugin 'scrooloose/nerdcommenter'
" Show marks when accessing
Plugin 'Yilin-Yang/vim-markbar'
"------------SYNTAX
" Nagios
Bundle 'vim-scripts/nagios-syntax'
" Nginx
Bundle 'nginx.vim'
" Puppet
Bundle 'rodjek/vim-puppet'
" MediaWiki
Bundle 'wikipedia.vim'
" Salt
Bundle 'saltstack/salt-vim'
" TWiki
Bundle 'vim-scripts/TWiki-Syntax'
" Singularity
Bundle 'singularityware/singularity.lang', {'rtp': 'vim/'}
" Jenkinsfile
Bundle 'martinda/Jenkinsfile-vim-syntax'
" Jinja
Bundle 'Glench/Vim-Jinja2-Syntax'
" Toml
Bundle 'cespare/vim-toml'
" Ansible
Bundle 'pearofducks/ansible-vim'
" Bytemark Custodian
Bundle 'user4574/custodian-syntax'
"------------COLOURSCHEME
" Apprentice Colorscheme
Bundle 'romainl/apprentice'
"---------------------------------
call vundle#end()
filetype plugin indent on " Enable filetype plugins

"---------------------------------
" Colour Scheme Setup
"---------------------------------
" If its a not a tty1-7 term and
" a preferred cs is installed use it
" Else use pablo
if $TERM !=# 'linux'
    try
        set t_Co=256
        colorscheme apprentice
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme pablo
        set background=dark
    endtry
else
    colorscheme pablo
endif

syntax on " Turn syntax highlighting on

"---------------------------------
" Colour Scheme Tweaks
"---------------------------------

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
set visualbell " Visual Bell only
set modelines=5 " Fixes OSX not reading modelines
set backspace=2 " Improve backspace

set undofile " Persistent undo history
" Store undo files in fixed location, not current directory.
if !empty($HOME)
    if !isdirectory($HOME . '/.vimundo')
        call mkdir($HOME . '/.vimundo')
    endif
    set undodir=~/.vimundo
endif

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

set title " Set title of term window

" Show Mode and Command in bar
set showmode
set showcmd

" List tab completions and cycle
set wildmenu

" Autoclose quickfix if last window
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype ==? 'quickfix'
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

" Store swap files in fixed location, not current directory.
if !empty($HOME)
    if !isdirectory($HOME . '/.vimswap')
        call mkdir($HOME . '/.vimswap')
    endif
    set directory=~/.vimswap//
endif

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Delete trailing whitespace on save
autocmd BufWritePre * :call DeleteTrailingWhitespace()

function! DeleteTrailingWhitespace()
    let save_pos = getpos('.')
    %s/\s\+$//e
    call setpos('.', save_pos)
endfunction

"---------------------------------
" Set Status Line
"---------------------------------
set laststatus=2
" ALE linter info for status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '[W%d E%d]',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=
" Column, Line, Total line count
set statusline+=\ %c:%l[%L]
" Syntax of file and lint status
set statusline+=[%{&syntax}]%{LinterStatus()}
" Git status
set statusline+=%{FugitiveStatusline()}
" Read only flag and modified flag
set statusline+=%r%m%<
" Left / right separator
set statusline+=%=
" user@host
set statusline+=%{$USER}@%{hostname()}
" File name
set statusline+=\ %.30F
set statusline+=\ |

"---------------------------------
" File Settings
"---------------------------------
set encoding=utf-8
set fileencoding=utf-8

" Disable two spaces after .
set nojoinspaces

" Tab / Indent setup
set expandtab "Tab inserts spaces
set shiftround " Round > indents to sw
set softtabstop=4 "Number of spaces that a <Tab> counts for when inserting
set shiftwidth=4 "Indent size for autoindent

" Use 2 space indent for certain filetypes
au FileType ruby setlocal shiftwidth=2 softtabstop=2
au FileType yaml setlocal shiftwidth=2 softtabstop=2

" Use Bash Higlighting not sh
let g:is_bash = 1

"---------------------------------
" File Syntax Settings
"---------------------------------
au BufRead,BufNewFile audit.rules set filetype=sh
au BufRead,BufNewFile auditd.rules set filetype=sh
au BufRead,BufNewFile *.eyaml set filetype=yaml
au BufRead,BufNewFile eyaml_edit* set filetype=yaml
au BufRead,BufNewFile *.md set filetype=markdown
" Use tcl for module files
au BufRead,BufNewFile *
    \ if getline(1) =~ '^#%Module' |
    \   set filetype=tcl |
    \ endif
au BufRead,BufNewFile *.twiki set filetype=twiki
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au BufRead,BufNewFile *.tmpl set filetype=jinja

"---------------------------------
" Plugin Settings
"---------------------------------

" ALE
" Enable completion where available.
let g:ale_completion_enabled = 1
" Always show sign gutter
let g:ale_sign_column_always = 1
" Don't highlight errors (messes with syntax highlighting)
let g:ale_set_highlights = 0
" Enable more linters
let g:ale_linters = {'python': ['pydocstyle', 'pylint', 'flake8']}
" CtrlP
let g:ctrlp_extensions = ['tag', 'buffertag', 'line', 'mixed']
let g:ctrlp_mruf_relative = 1
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore= 'vendor\|env'

" Nerdcommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDCommentEmptyLines = 1
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Markbar
let g:markbar_marks_to_display = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:markbar_peekaboo_marks_to_display = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

"---------------------------------
" Keybindings
"---------------------------------
" Map Leader
" mapped to ,
let mapleader = ','
let g:mapleader = ','

" Generate tags
map <Leader>gt :!ctags -R<CR>

" Toggle location list
map <Leader>ll :lopen<CR>

" Next location
map <Leader>lln :lnext<CR>

" Better window resizing
" - Height
map <Leader>= :resize +5<CR>
map <Leader>- :resize -5<CR>
" - Width (Shift)
map <Leader>+ :vertical resize +5<CR>
map <Leader>_ :vertical resize -5<CR>

" List Buffers
map <Leader>lb :ls<CR>

" Split Buffer
map <Leader>xb <Esc>:sb<space>

" Vert Split Buffer
map <Leader>vb <Esc>:ls<CR>:vert sb<Space>

" Switch Buffer
map <Leader>sb <Esc>:ls<CR>:b<Space>

" Override CTRL+L to clear and remove search highlighting
nnoremap <c-l> :noh<CR><c-l>

" Switch *# direction (search for w)
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

" Comment line (Nerdcommenter)
nmap <Leader># <plug>NERDCommenterToggle
vmap <leader># <plug>NERDCommenterToggle gv

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
map <Leader>nn :set number! <bar> :set relativenumber!<CR>
"map <Leader>nn :set number!<CR>

"----------------- Signs
sign define mefsign text=M> linehl=Search texthl=Search
map <Leader>ss :exec 'sign place '.line(".").'  name=mefsign line='.line(".")<CR>
map <Leader>ds :exec 'sign unplace '.line(".")<CR>

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
