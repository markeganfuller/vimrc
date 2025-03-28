filetype off      " Turn Filetype off until plugins have been loaded

"---------------------------------
" Setup Vundle
"---------------------------------
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

"---------------------------------
" Vundle Plugins
"---------------------------------
" Tabuliser for => in puppet etc
Plugin 'godlygeek/tabular'
" Git Commands
Plugin 'tpope/vim-fugitive.git'
" Git Diff in Gutter
Plugin 'airblade/vim-gitgutter'
" Buffer Line
Plugin 'bling/vim-bufferline'
" CTRL P
Plugin 'ctrlpvim/ctrlp.vim'
" ALE syntax checking
Plugin 'w0rp/ale'
" Python indentation
Plugin 'hynek/vim-python-pep8-indent'
" Show registers when accessing
Plugin 'junegunn/vim-peekaboo'
" Comments
Plugin 'scrooloose/nerdcommenter'
" Show marks when accessing
Plugin 'Yilin-Yang/vim-markbar'
" Auto toggle relative / absolute numbers
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
" Vader vimscript testing
Plugin 'junegunn/vader.vim'
" Vim Github Link
Plugin 'knsh14/vim-github-link'
"------------SYNTAX
" Nagios
Plugin 'vim-scripts/nagios-syntax'
" Nginx
Plugin 'nginx.vim'
" Puppet
Plugin 'rodjek/vim-puppet'
" MediaWiki
Plugin 'wikipedia.vim'
" Salt
Plugin 'saltstack/salt-vim'
" TWiki
Plugin 'vim-scripts/TWiki-Syntax'
" Singularity
Plugin 'singularityware/singularity.lang', {'rtp': 'vim/'}
" Jenkinsfile
Plugin 'martinda/Jenkinsfile-vim-syntax'
" Jinja
Plugin 'Glench/Vim-Jinja2-Syntax'
" Toml
Plugin 'cespare/vim-toml'
" Ansible
Plugin 'pearofducks/ansible-vim'
" Bytemark Custodian
Plugin 'user4574/custodian-syntax'
" Pug HTML templating (formerly known as Jade)
Plugin 'digitaltoad/vim-pug'
" YARA
Plugin 'yaunj/vim-yara'
" Handling for Heredocs in shell scripts
Plugin 'markeganfuller/vim-heredoc'
" Github Actions Yaml
Plugin 'yasuhiroki/github-actions-yaml.vim'
" Terraform
Plugin 'hashivim/vim-terraform'
" Dockerfile
Plugin 'ekalinin/Dockerfile.vim'
" Mikrotik RouterOS
Plugin 'krcs/vim-routeros-syntax'
"------------COLOURSCHEME
" Apprentic Colorscheme
Plugin 'romainl/Apprentice'
"---------------------------------
call vundle#end()
filetype plugin indent on " Enable filetype plugins
set viminfo+=! " Save and restore uppercase global vars

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

        function! MyApprenticeOverrides() abort
            " Make line numbers and sign background match rest of window
            highlight LineNr ctermbg=NONE guibg=NONE
            highlight signColumn ctermbg=NONE guibg=NONE
            "  Make NonText and SpecialKey stand out
            highlight NonText ctermfg=magenta guifg=#8787af
            highlight SpecialKey ctermfg=magenta guifg=#8787af
            " Make search less bright
            highlight Search ctermfg=234 guifg=#1c1c1c ctermbg=186 guibg=#d7d787
            " Make comments brighter
            highlight Comment ctermfg=242 guifg=#6c6c6c
            " Inverted statusline for inactive split.
            highlight StatusLine ctermfg=234 guifg=#1c1c1c
            highlight StatusLineNC ctermbg=234 guibg=#1c1c1c
            " Adjust MatchParen for easier visibility.
            highlight MatchParen ctermbg=NONE guibg=NONE ctermfg=magenta guifg=#8787af
            " Traditional diff colours
            highlight DiffAdd ctermbg=235 ctermfg=108 cterm=reverse guibg=#262626 guifg=#87af87 gui=reverse
            highlight DiffChange ctermbg=235 ctermfg=103 cterm=reverse guibg=#262626 guifg=#8787af gui=reverse
            highlight DiffDelete ctermbg=235 ctermfg=131 cterm=reverse guibg=#262626 guifg=#af5f5f gui=reverse
            highlight DiffText ctermbg=235 ctermfg=208 cterm=reverse guibg=#262626 guifg=#ff8700 gui=reverse
        endfunction

        augroup MyColors
            autocmd!
            autocmd colorscheme apprentice call MyApprenticeOverrides()
        augroup END

    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme pablo
        set background=dark
    endtry
else
    colorscheme pablo
endif

syntax on " Turn syntax highlighting on

"---------------------------------
" Setup augroup
"---------------------------------
augroup vimrc
    " Clean any previous load
    autocmd!
augroup END

"---------------------------------
" Editor Settings
"---------------------------------
set shell=bash " Set Shell
set history=700 " Set history size
set autoread " Auto read a file when its changed
set belloff=all " No bells
set nomodeline " Disable modeline
set backspace=2 " Improve backspace
" Define non printable character display
set listchars=eol:$,tab:⇥·,extends:>,precedes:<,space:␣
" Make vertical splits use space char not |
set fillchars+=vert:\  "Significant whitespace
set undofile " Persistent undo history
set backup " Backup when writing a file
" Store undo files in fixed location, not current directory.
if !empty($HOME)
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
set ignorecase " Case insensitive search
set smartcase " Case sensitive if upper case in search term

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
" Make the tab completion more shell-like
set wildmode=longest:full,full

" Configure diff to use indent-heuristic and patience
set diffopt+=indent-heuristic,algorithm:patience

" Disable folds
set nofoldenable

" Map Leader
" mapped to ,
let mapleader = ','
let g:mapleader = ','

" Autoclose quickfix if last window
autocmd vimrc BufEnter * call MyLastWindow()
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
autocmd vimrc CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd vimrc InsertLeave * if pumvisible() == 0|pclose|endif

" Diff Buffer against file
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" SQL Formatting, requires python-sqlparse
command -range SQLFormat <line1>,<line2>!sqlformat - --indent_width 4 --indent_columns --wrap_after 79 --keywords upper

" Tabularize single space delimiter to min 1 space
command -range TabSingleSpace <line1>,<line2>Tabularize /\s\+/l0

" Store swap/backup/undo files in fixed location, not current directory.
if !empty($HOME)
    if !isdirectory($HOME . '/.vimswap')
        call mkdir($HOME . '/.vimswap')
    endif
    set directory=~/.vimswap//

    if !isdirectory($HOME . '/.vimbackup')
        call mkdir($HOME . '/.vimbackup')
    endif
    set backupdir=~/.vimbackup//

    if !isdirectory($HOME . '/.vimundo')
        call mkdir($HOME . '/.vimundo')
    endif
    set undodir=~/.vimundo
endif

" Return to last edit position when opening files
autocmd vimrc BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Delete trailing whitespace on save
autocmd vimrc BufWritePre * :call DeleteTrailingWhitespace()
" Add timestamp to backup file name
autocmd vimrc BufWritePre * let &backupext = '~' . strftime('%FT%T%z')
" Clean up old backups on exit
autocmd vimrc VimLeave * :call system('find ~/.vimbackup -mtime +14 -delete')

function! DeleteTrailingWhitespace()
    " Don't do it for diff files (patches etc)
    if (&filetype!=?'diff')
        let view = winsaveview()
        %s/\s\+$//e
        call winrestview(view)
    endif
endfunction

function ToggleCopyMode()
    if &scl ==? 'no'
        set scl=auto
        set number!
        set relativenumber!
    else
        set scl=no
        set number!
        set relativenumber!
    endif
endfunction

" Auto resize windows (equalise) on vim resize
autocmd vimrc VimResized * wincmd =

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

"Get git top level directory (so we can get local repo name)
"Useful for when we have multiple check outs of the same repo with differnt
"names locally
function! GitTopLevelStatus() abort
    :silent let l:git_top_level = trim(system("git rev-parse --show-toplevel 2>/dev/null"))
    if strlen(l:git_top_level)
        return '[' . fnamemodify(l:git_top_level, ':t') . ']'
    else
        return ''
    endif
endfunction

set statusline=
" Column, Line, Total line count
set statusline+=\ %c:%l[%L]
" Syntax of file and lint status
set statusline+=[%{&syntax}]%{LinterStatus()}
" Git status
set statusline+=%{FugitiveStatusline()}
" Local Repo name
set statusline+=%{GitTopLevelStatus()}
" Read only flag and modified flag
set statusline+=%r%m%<
" Left / right separator
set statusline+=%=
" File name
set statusline+=\ %F
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
autocmd vimrc FileType ruby setlocal shiftwidth=2 softtabstop=2
autocmd vimrc FileType yaml setlocal shiftwidth=2 softtabstop=2
autocmd vimrc FileType pug setlocal shiftwidth=2 softtabstop=2 "Formally known as Jade

" Use Bash Higlighting not sh
let g:is_bash = 1
" Make syntax calculation start 500 lines before
" Avoids issues with temporarily broken highlighting
let g:sh_minlines = 500
" Enable syntax highlighting in heredocs
let g:heredoc_matches = [['SHELL', 'sh'], ['PYTHON', 'python']]

"---------------------------------
" File Syntax Settings
"---------------------------------
autocmd vimrc BufRead,BufNewFile audit.rules set filetype=sh
autocmd vimrc BufRead,BufNewFile auditd.rules set filetype=sh
autocmd vimrc BufRead,BufNewFile *.eyaml set filetype=yaml
autocmd vimrc BufRead,BufNewFile eyaml_edit* set filetype=yaml
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
" Use tcl for module files
autocmd vimrc BufRead,BufNewFile *
    \ if getline(1) =~ '^#%Module' |
    \   set filetype=tcl |
    \ endif
autocmd vimrc BufRead,BufNewFile *.twiki set filetype=twiki
autocmd vimrc BufRead,BufNewFile Vagrantfile set filetype=ruby
autocmd vimrc BufRead,BufNewFile *.tmpl set filetype=jinja

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
let g:ale_fixers = {'ruby': ['rubocop']}
" Set jump keybinding for ALE
map <Leader>aa :ALENext<CR>
" Disable virtualtext (inline error messages)
let g:ale_virtualtext_cursor = 'disabled'

" CtrlP
let g:ctrlp_extensions = ['tag', 'buffertag', 'line', 'mixed']
let g:ctrlp_mruf_relative = 1
let g:ctrlp_cmd = 'CtrlPMixed'
" Warning this is vim regex, its weird \| is a pattern delimiter here
let g:ctrlp_custom_ignore = {
    \ 'dir': '/vendor$\|/env$\|/\.git$\|/\.terraform$\|/coverage$',
    \ }

let g:ctrlp_show_hidden=1
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 1000
let g:ctrlp_clean_cache_on_exit = 0

" Run CtrlP in current dir only, useful when we're in a big git repo (like a
" puppet control repo with all the modules in it)
map <Leader>p :let g:ctrlp_working_path_mode = 'a' \| CtrlPMixed \| let g:ctrlp_working_path_mode = 'ra'<CR>

" CtrlP - Don't index home
" https://github.com/kien/ctrlp.vim/issues/560#issuecomment-168463350
augroup vimrc
    autocmd VimEnter * nnoremap <C-P> :call RunCtrlP()<CR>
augroup END
fun! RunCtrlP()
    if (getcwd() == $HOME)
        echo 'Not running CtrlP in $HOME'
        return
    endif
    execute g:ctrlp_cmd
endfunc

" Nerdcommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDCommentEmptyLines = 1
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Markbar
let g:markbar_marks_to_display = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:markbar_peekaboo_marks_to_display = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
" Using hidden buffers is faster but explodes if you have multiple instances
" of vim
let g:markbar_cache_with_hidden_buffers = v:false

" Github Link
map <Leader>gl :GetCommitLink<CR>

"---------------------------------
" Keybindings
"---------------------------------
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
nnoremap <c-o> <c-i>
nnoremap <c-i> <c-o>

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

" Insert a newline
nmap <Leader><Space><Space> :normal o<ESC>

" Comment line (Nerdcommenter)
nmap <Leader># <plug>NERDCommenterToggle
vmap <Leader># <plug>NERDCommenterToggle gv

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

" Match non breaking spaces and show as errors
" Commonly seen when copy pasting from confluence
map <Leader>ms :match Error /\%u00a0\+/<cr>

" Clear Matches
map <Leader>mn :match NONE<cr>

" Toggle Spell Checking
map <Leader>sp :setlocal spell!<cr>

" Toggle Paste Mode
map <Leader>pp :setlocal paste!<cr>

" Toggle Copy Mode (hide all except content)
map <Leader>pc :call ToggleCopyMode()<CR>

" Toggle Line Numbers
map <Leader>nn :set number! <bar> :set relativenumber!<CR>

" Toggle listchars (non-printable chars)
map <leader>lc :set list!<CR>

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
