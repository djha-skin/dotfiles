let mapleader="\<SPACE>"

if has('win32')
    let g:python3_post_prog = 'C:\Python39\python.exe'
endif
let g:black_linelength = 79

call plug#begin('~/AppData/Local/nvim/plugged')
" below are some vim plugins for demonstration purpose.
" add the plugin you want to use here.
Plug 'jpalardy/vim-slime'
Plug 'guns/vim-clojure-static'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

" DIE, BELL
set noeb vb t_vb=
set belloff=all

let maplocalleader=","
"set t_Co=256
"set foldmethod=syntax
set t_vb=

set noeol
set nobomb
set nocompatible
filetype indent on
filetype plugin on
if has('win32')
    set backspace=indent,eol,start
elseif has('win32unix')
    "Cygwin options
    "set backspace=2
    "if that doesn't work, try this:
    set backspace=indent,eol,start
"http://superuser.com/a/194718/91022
"elseif has('mac')
"...
"elseif has('unix')
"...
elseif has('unix')
    set background=dark
endif
colorscheme simple
syntax enable

set formatoptions+=o
set nojoinspaces
set showmatch

if has('win32')
    let g:slime_target = "conemu"
    set backspace=2
    colorscheme simple
    setlocal nobomb
    setglobal nobomb
elseif has('unix')
    let g:slime_target = "screen"
    let g:slime_window_name = "repl"
    let g:slime_session_name= "ergo"
    let b:slime_config = {"sessionname": "ergo", "windowname": "repl"}
    let g:slime_paste_file = "$HOME/.slime_paste"

    set background=dark
    colorscheme simple
endif
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '/\%>80v.\+/', -1)
" guard against 80 character length lines.
hi clear OverLength
hi clear ExtraWhitespace
hi ExtraWhitespace ctermbg=red guibg=red
hi link OverLength Error
match OverLength '\%>80v.\+'
2match ExtraWhitespace '\s\+\%#\@<!$'
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('OverLength', '/\%>80v.\+/', -1)
endif

set expandtab
set tabstop=4
set shiftwidth=4
set number
set ruler
set modeline
set cursorline
"set cursorlineopt=line

set viminfo='20,\"1000
set pastetoggle=<F3>
set hlsearch
map!  u03bb

" enable unicode
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
  setglobal nobomb
  set nobomb
  setlocal nobomb
  set encoding=utf-8
  setlocal encoding=utf-8
  setglobal encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencoding=utf-8
  setlocal fileencoding=utf-8
endif

map ]] :call searchpair('\[', '', '\]', 'W')
map [[ :call searchpair('\[', '', '\]', 'bW')
" trim lines of whitespace
map <Leader>t :s/\v[[:blank:]][[:blank:]]*$//g<CR>
map <Leader>T :%s/\v[[:blank:]][[:blank:]]*$//g<CR>
imap jk <Esc>
nnoremap <Leader><space> :let @/=""<CR>
nnoremap <Leader>d :put =strftime('%FT%T%z')<CR>
nnoremap <Leader>b :execute "!git blame -L " . line(".") . "," . line(".") . " %"<CR>

"au BufRead,BufNewFile *.c,*.h set makeprg=gcc\ \"%\"
au BufRead,BufNewFile *.rkt,*.rktl  set filetype=racket
" insert a unicode lambda on C-\
"au filetype racket set makeprg=raco\ exe\ \"%\"

au BufRead,BufNewFile Jenkinsfile set syntax=groovy
au BufRead,BufNewFile *.go set tabstop=4 shiftwidth=4 noexpandtab makeprg=go\ build\ .
au BufRead,BufNewFile *.py set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p | set errorformat=%f:%l:\ %m
au BufWritePre *.py execute ':Black'
au BufRead,BufNewFile *.yml set tabstop=2 | set shiftwidth=2 | set indentexpr= | set smartindent
au BufRead,BufNewFile *.yaml set tabstop=2 | set shiftwidth=2 | set indentexpr= | set smartindent
au BufRead,BufNewFile *.pl set makeprg=perl\ \"%\"
au BufRead,BufNewFile *.scm  set makeprg=mit-scheme\ --load\ \"%\"
au BufRead,BufNewFile *.java set makeprg=javac\ -classpath\ .\ -Xlint\ \"%\"
au BufRead,BufNewFile *.m set makeprg=octave\ \"%\"
au BufRead,BufNewFile Makefile.am set makeprg=automake
au BufRead,BufNewFile COMMIT_EDITMSG set textwidth=72
au BufRead,BufNewFile *.v   set filetype=coq
au BufRead,BufNewFile *.v   set makeprg=coqc\ \"%\"
au BufRead,BufNewFile *.rs   set makeprg=cargo\ build
au BufRead,BufNewFile *.clj set makeprg=lein\ compile
au BufRead,BufNewFile *.tex set makeprg=pdflatex\ -halt-on-error\ --shell-escape\ -interaction=nonstopmode\ \"%\"
au BufRead,BufNewFile SConstruct,SConscript set makeprg=scons
au BufRead,BufNewFile *.rb set tabstop=2
au BufRead,BufNewFile *.rb set shiftwidth=2
au BufRead,BufNewfile *.md set tabstop=2 | set shiftwidth=2 | inoremap <CR> <CR><esc>i
au BufRead,BufNewFile *.hs set shiftwidth=2 | set tabstop=2
au BufRead,BufNewFile *.mtn set tabstop=8 | set shiftwidth=8 | set noexpandtab

" make pretty formatted use of variables
"au filetype sh map! $$ ${}OD
" enclose any variable within a line in quotes
"au filetype sh map \" :.s/\v(^\|[[:blank:]])(\$[^[:blank:]]*)([[:blank:]]\|$)/\1"\2"\3/g

"if has("terminal")
"    let g:slime_target="vimterminal"
"    if has("win32")
"        let g:slime_vimterminal_cmd = "powershell"
"    else
"        let g:slime_vimterminal_cmd = "bash"
"    endif
"else
"endif

let g:go_disable_autoinstall = 0

" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1


if exists('g:vscode')
    nnoremap <Leader>j :call VSCodeNotify('calva.jackIn')<CR>
    nnoremap <Leader>q :call VSCodeNotify('calva.disconnect')<CR>
    nnoremap <Leader>f :call VSCodeNotify('calva.loadFile')<CR>
    nnoremap <Leader>n :call VSCodeNotify('calva.loadNamespace')<CR>
    nnoremap <Leader>s :call VSCodeNotify('calva.evaluateSelection')<CR>
    nnoremap <Leader>c :call VSCodeNotify('calva.evalCurrentFormInREPLWindow')<CR>
endif
