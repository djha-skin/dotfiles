let mapleader="\<SPACE>"
"if has('win32')
"    let &shell = '"C:\WINDOWS\system32\cmd.exe"'
"    let g:python3_post_prog = 'C:\Python39\python.exe'
"    set shellcmdflag=/c
"endif


let g:black_linelength = 79
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 2

call plug#begin()
Plug 'jpalardy/vim-slime'
"Plug 'vlime/vlime', {'rtp': 'vim/'}
"Plug 'guns/vim-clojure-static'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'frazrepo/vim-rainbow'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
Plug 'preservim/vim-markdown'
Plug 'overcache/NeoSolarized'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
"if has('win32')
"    Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only'
"    Plug 'frankier/neovim-colors-solarized-truecolor-only'
"else
"    Plug 'altercation/vim-colors-solarized'
"endif
Plug 'guns/vim-sexp'
call plug#end()
let g:sexp_enable_insert_mode_mappings = 0
let g:paredit_mode=0

lua <<EOF
require'lspconfig'.clojure_lsp.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.terraformls.setup{}

function str2file(str, fname)
  local f = assert(io.open(fname, "w"))
  f:write(str)
  f:close()
end
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"set completeopt=menuone,noselect
"set completeopt-=preview
" use omni completion provided by lsp
"
"autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

set nofixendofline
" DIE, BELL
set noeb vb t_vb=
set belloff=all
let g:rainbow_active = 1

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
endif
syntax enable

set formatoptions+=o
set nojoinspaces
set showmatch

"let g:slime_target = "neovim"
set background=light

if exists('+termguicolors')
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
endif

if executable('tmux')
    if has('win32')
        let &shell = "C:/Users/bhw/scoop/apps/msys2/current/usr/bin/bash"
        set shellcmdflag=-c
        set shellquote=
        set shellxquote=
        let g:slime_paste_file = "/c/Users/bhw/.slime_paste"
        colorscheme delek
        let g:slime_default_config = {"socket_name": "default", "target_pane": ":.0"}
    else
        let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.0"}
    endif
    let g:slime_target = "tmux"
    let g:slime_paste_file = expand(".slime_paste")
else
    colorscheme NeoSolarized
    let g:slime_target = "conemu"
endif

if has('win32')
    set backspace=2
    setlocal nobomb
    setglobal nobomb
endif

au BufWinEnter * let w:m2=matchadd('ErrorMsg', '/\%>80v.\+/', -1)
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
tnoremap jk <C-\><C-n>





nnoremap <Leader><space> :let @/=""<CR>
nnoremap <Leader>d :put =strftime('%FT%T%z')<CR>
nnoremap <Leader>b :execute "!git blame -L " . line(".") . "," . line(".") . " %"<CR>
" Easier copy/pasta
if has("unix")
    vnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), '/tmp/screen-exchange')<CR>
    nnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), '/tmp/screen-exchange')<CR>
    nnoremap <Leader>v "+]p
    nnoremap <Leader>V :r /tmp/screen-exchange<CR>
elseif has("win32")
    vnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), "C:\\Users\\bhw\\AppData\\Local\\Temp\\vim-exchange.txt")<CR>
    nnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), "C:\\Users\\bhw\\AppData\\Local\\Temp\\vim-exchange.txt")<CR>
    nnoremap <Leader>v "+]p
    nnoremap <Leader>V :r "C:\\Users\\bhw\\AppData\\Local\\Temp\\vim-exchange.txt"<CR>
endif
nnoremap <Leader>o :FZF<CR>
nnoremap <Leader>( t(l"pda(hda("pp
nnoremap <Leader>l :lua vim.diagnostic.setloclist()<CR>
" the leader f won't work with this, but the leader G will.
nnoremap <Leader>r :lua vim.fn.execute("r!screen2vim '" ..  vim.fn.expand("%:p") .. "' 'img'")<CR>
vnoremap <Leader>c "+y
nnoremap <Leader>v "+]p
nnoremap <Leader>n :tabn<CR>
nnoremap <Leader>p :tabp<CR>

nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

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
au BufRead,BufNewFile *.xml set tabstop=4 | set shiftwidth=4 | map <Leader>F :%!xmllint --format -<CR>
au BufRead,BufNewFile *.pl set makeprg=perl\ \"%\"
au BufRead,BufNewFile *.scm  set makeprg=mit-scheme\ --load\ \"%\"
" au BufRead,BufNewFile *.java set makeprg=javac\ -classpath\ .\ -Xlint\ \"%\"
au BufRead,BufNewFile *.m set makeprg=octave\ \"%\"
au BufRead,BufNewFile Makefile.am set makeprg=automake
au BufRead,BufNewFile COMMIT_EDITMSG set textwidth=72
au BufRead,BufNewFile *.v   set filetype=coq
au BufRead,BufNewFile *.v   set makeprg=coqc\ \"%\"
au BufRead,BufNewFile *.rs   set makeprg=cargo\ build
au BufRead,BufNewFile *.clj set makeprg=lein\ compile | map <Leader>F :!cljstyle fix %<CR>
au BufRead,BufNewFile *.clj nnoremap <Leader>u t(l"ada(da(h"a]p
au BufRead,BufNewFile *.clj nnoremap <Leader>U dt xjkhxt)lx
au BufRead,BufNewFile *.clj nnoremap <Leader>d i(util/dbg <Esc>l])a)<Esc>
au BufRead,BufNewFile *.clj nnoremap <Leader>D bi(util/dbg <Esc>lea)<Esc>
au BufRead,BufNewFile *.tex set makeprg=pdflatex\ -halt-on-error\ --shell-escape\ -interaction=nonstopmode\ \"%\"
au BufRead,BufNewFile SConstruct,SConscript set makeprg=scons
au BufRead,BufNewFile *.rb set tabstop=2
au BufRead,BufNewFile *.rb set shiftwidth=2
"au BufRead,BufNewFile *.lisp lua clstart()
"| inoremap <CR> <CR><esc>i

" https://github.com/preservim/vim-markdown/issues/390#issuecomment-578459147
"let g:vim_markdown_auto_insert_bullets=0
"let g:vim_markdown_new_list_item_indent=0
"au BufRead,BufNewfile *.md set tabstop=2 | set shiftwidth=2 | setlocal formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[*+~-]\\s\\+\\\|^\\(\\\|[*#]\\)\\[^[^\\]]\\+\\]:\\s | setlocal comments=n:> | setlocal formatoptions+=cn

"https://github.com/preservim/vim-markdown/issues/390#issuecomment-450392655
"https://github.com/preservim/vim-markdown/pull/375
"| setlocal comments=bf:>,bf:*,bf:+,bf:- | set formatoptions+=c  | set formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[#*+~-]\\s\\+\\\|^\\(\\\|[*#-~+]\\)\\[^[^\\]]\\+\\]:\\s
au BufRead,BufNewFile *.md set shiftwidth=2 | set tabstop=2 | setlocal comments=bf:*,bf:+,bf:-,n:> | set formatoptions+=c  | set formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[#*+~-]\\s\\+\\\|^\\(\\\|[*#-~+]\\)\\[^[^\\]]\\+\\]:\\s | set textwidth=80


au BufRead,BufNewFile *.hs set shiftwidth=2 | set tabstop=2
au BufRead,BufNewFile *.mtn set tabstop=8 | set shiftwidth=8 | set noexpandtab
au BufRead,BufNewFile *.tsv set tabstop=8 | set shiftwidth=8 | set noexpandtab
au BufWritePost *.tf !terraform fmt %
au BufRead,BufNewFile *.eml set colorcolumn=75 | map <LocalLeader>m :r!get-message-id %<CR>
autocmd TermOpen * setlocal nospell

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
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 1

if exists('g:vscode')
    nnoremap <Leader>j :call VSCodeNotify('calva.jackIn')<CR>
    nnoremap <Leader>q :call VSCodeNotify('calva.disconnect')<CR>
    nnoremap <Leader>f :call VSCodeNotify('calva.loadFile')<CR>
    nnoremap <Leader>n :call VSCodeNotify('calva.loadNamespace')<CR>
    nnoremap <Leader>s :call VSCodeNotify('calva.evaluateSelection')<CR>
    nnoremap <Leader>C :call VSCodeNotify('calva.evaluateCurrentTopLevelForm')<CR>
endif
