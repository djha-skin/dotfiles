set spell spelllang=en
let mapleader="\<SPACE>"

filetype off
set runtimepath+=/usr/local/share/lilypond/current/vim/
filetype on
syntax on

runtime background.vim

if has('win32')
  let g:slime_target = "conemu"
  let b:slime_target = "conemu"
  let b:slime_default_config = {"HWND": "O:T1"}
  let g:slime_default_config = {"HWND": "0:T1"}
  let b:slime_config = {"HWND": "O:T1"}
  let g:slime_config = {"HWND": "O:T1"}
else
  let b:slime_target = "tmux"
  let g:slime_target = "tmux"
  let b:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.0"}
  let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.0"}
  let b:slime_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.0"}
  let g:slime_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.0"}
endif

let g:black_linelength = 79
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 2
let b:slime_debug = 0
let g:slime_debug = 0
let b:slime_no_mappings = 1
let g:slime_no_mappings = 1
xmap <Leader>g <Plug>SlimeRegionSend
nmap <Leader>g <Plug>SlimeParagraphSend
nmap <Leader>G <Plug>SlimeConfig


if len($TMUX) > 0
    if has('win32')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

        let &shell = "C:/Users/bhw/scoop/apps/msys2/current/usr/bin/bash"
        set shellcmdflag=-c
        set shellquote=
        set shellxquote=
        let g:slime_paste_file = "/c/Users/bhw/.slime_paste"
        let g:slime_default_config = {"socket_name": "default", "target_pane": ":.0"}
        let b:slime_default_config = {"socket_name": "default", "target_pane": ":.0"}
    else
        let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.0"}
        let b:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.0"}
    endif
    let g:slime_target = "tmux"
    let b:slime_target = "tmux"
    let g:slime_paste_file = expand(".slime_paste")
    let b:slime_paste_file = expand(".slime_paste")
endif

call plug#begin()
if has('mac')
    let g:netrw_browser_viewer='open'
    if len($TERM_PROFILE) > 0
    endif
elseif has('win32')
    set shellslash
    let g:netrw_browser_viewer='start'
    "let g:clipboard = {
    "            \   'name': 'WslClipboard',
    "            \   'copy': {
    "            \      '+': 'clip.exe',
    "            \      '*': 'clip.exe',
    "            \    },
    "            \   'paste': {
    "            \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    "            \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    "            \   },
    "            \   'cache_enabled': 0,
    "            \ }
else
    let g:netrw_browser_viewer='xdg-open'
endif

call plug#begin()
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvim-lua/plenary.nvim'
"Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --go-completer --ts-completer --rust-completer --java-completer' }
"Plug 'gsuuon/llm.nvim'
"Plug 'Olical/conjure'
Plug 'djhaskin987/vim-slime'
Plug 'bakpakin/janet.vim'
Plug 'github/copilot.vim'
Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'rhysd/vim-grammarous'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'ray-x/go.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'frazrepo/vim-rainbow'
Plug 'godlygeek/tabular'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
Plug 'preservim/vim-markdown'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'overcache/NeoSolarized'
Plug 'guns/vim-sexp'
Plug 'https://git.sr.ht/~skin/roswell-sbcl.vim'
Plug 'vim-scripts/DrawIt'
call plug#end()


let g:sexp_enable_insert_mode_mappings = 0
let g:paredit_mode=1
nnoremap <Leader>w <C-w>
nnoremap <Leader>ww <C-w><C-w>
vnoremap <Leader>r y<C-w>wpa<CR><C-\><C-n><C-w>p

"let g:ycm_language_server =
"\ [
"\   {
"\     'name': 'common-lisp',
"\     'cmdline': [ 'cl-lsp', '--stdio' ],
"\     'filetypes': [ 'lisp' ]
"\   },
"\   {
"\     'name': 'terraform',
"\     'cmdline': [ 'terraform-lsp', 'serve' ],
"\     'filetypes': [ 'terraform' ]
"\   }
"\ ]
"

lua <<EOF

require 'lspconfig'.clojure_lsp.setup{}
require 'lspconfig'.pylsp.setup{}
require 'lspconfig'.terraformls.setup{}
require 'lspconfig'.gopls.setup{}

function clstart( )
    if ( not started)
    then
        started = true
        vim.lsp.start({
          name = 'cl-lsp',
          cmd = {'cl-lsp'},
          root_dir = vim.fs.dirname(vim.fs.find(function(name, path)
              return name:match('.asd$')
            end, { upward = true })[1]),
        })
    end
end

function str2file(str, fname)
  local f = assert(io.open(fname, "w"))
  f:write(str)
  f:close()
end
-- require('llm').setup({
-- prompts = vim.tbl_extend('force', require('llm.prompts.starters'), {
--   llamacpp = {
--     provider = llamacpp,
--     params = {
--       model = 'models/llama-2-13b-chat.ggmlv3.q4_K_M.bin',
--       ['n-gpu-layers'] = 32,
--       threads = 6,
--       ['repeat-penalty'] = 1.2,
--       temp = 0.2,
--       ['ctx-size'] = 4096,
--       ['n-predict'] = -1
--     },
--     builder = function(input)
--       return {
--         prompt = llamacpp.llama_2_format({
--           messages = {
--             input
--           }
--         })
--       }
--     end,
--     options = {
--       path = os.getenv('LLAMACPP_DIR'),
--       main_dir = os.getenv('LLAMACPP_MAIN_DIR')
--     }
--     }
--   })
-- })

-- "

EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"set completeopt=menuone,noselect
"set completeopt-=preview
" use omni completion provided by lsp
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
endif
"colorscheme NeoSolarized
colorscheme simple
syntax enable

set formatoptions+=o
set nojoinspaces
set showmatch

set termguicolors


if has('win32')
    set backspace=2
    setlocal nobomb
    setglobal nobomb
endif

" guard against 80 character length lines.
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '/\%>80v.\+/', -1)
"au BufWinEnter *.lisp let w:m2=matchadd('ErrorMsg', '/\%>100v.\+/', -1)

hi clear OverLength
hi link OverLength Error

au BufWinEnter * match OverLength '\%>80v.\+'
"au BufWinEnter *.lisp match OverLength '\%>100v.\+'
if exists('+colorcolumn')
    au BufWinEnter * set colorcolumn=80
    "au BufWinEnter *.lisp set colorcolumn=100
else
    au BufWinEnter * let w:m2=matchadd('OverLength', '/\%>80v.\+/', -1)
    "au BufWinEnter *.lisp let w:m2=matchadd('OverLength', '/\%>100v.\+/', -1)
endif
"au BufWinEnter *.lisp set textwidth=100

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
if has('multi_byte')
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
" Easier copy/pasta and other things
if has('unix')
    vnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), '/tmp/screen-exchange')<CR>
    nnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), '/tmp/screen-exchange')<CR>
    nnoremap <Leader>v "+]p
    nnoremap <Leader>V :r /tmp/screen-exchange<CR>
    au BufRead,BufNewFile *.md nnoremap <LocalLeader>v :w<CR>:execute "!sh -c \"zathura '%:r.pdf' &\""<CR>
    au BufRead,BufNewFile *.md nnoremap <LocalLeader>f :w<CR>:execute "!sh -c \"zathura '%' && sleep 1\""<CR>

elseif has('win32')
    vnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), "C:\\Users\\bhw\\AppData\\Local\\Temp\\vim-exchange.txt")<CR>
    nnoremap <Leader>c "+y:lua str2file(vim.fn.getreg('+'), "C:\\Users\\bhw\\AppData\\Local\\Temp\\vim-exchange.txt")<CR>
    nnoremap <Leader>v "+]p
    nnoremap <Leader>V :r "C:\\Users\\bhw\\AppData\\Local\\Temp\\vim-exchange.txt"<CR>
    au BufRead,BufNewFile *.md nnoremap <LocalLeader>v :w<CR>:execute "!sh -c \"start '%:r.pdf' &\""<CR>
    au BufRead,BufNewFile *.md nnoremap <LocalLeader>f :w<CR>:execute "!sh -c \"start '%' && sleep 1\""<CR>
endif
nnoremap <Leader>o :FZF<CR>
au BufRead,BufNewFile *.md nnoremap <LocalLeader>q :let @/=""<CR>:s/^\( *\)\(- *\)\{0,1\}\(\[.\]\)\{0,1\} \{1,\}\([^ ].*\) *$/\1\2\3 \~\~\4\~\~/<CR>:let @/=""<CR>
au BufRead,BufNewFile *.md nnoremap <LocalLeader>w :let @/=""<CR>:s/^\( *\)\(- *\)\{0,1\}\(\[.\]\)\{0,1\} */\1- [x] /g<CR>:let @/=""<CR>
au BufRead,BufNewFile *.md nnoremap <LocalLeader>e :let @/=""<CR>:s/^\( *\)\(- *\)\{0,1\}\(\[.\]\)\{0,1\} */\1- [ ] /g<CR>:let @/=""<CR>
au BufRead,BufNewFile *.md nnoremap <LocalLeader>r :let @/=""<CR>:s/^\( *\)\(- *\)\{0,1\}\(\[.\]\)\{0,1\} */\1/g<CR>:let @/=""<CR>
au BufRead,BufNewFile *.md nnoremap <LocalLeader>t :let @/=""<CR>:s/^\( *\)\(- *\)\{0,1\}\(\[.\]\)\{0,1\} *[~]\{2\}\(.*\)[~]\{2\} *$/\1\2\3 \4/<CR>:let @/=""<CR>
au BufRead,BufNewFile *.md set makeprg=markdown-to-pdf\ %\ %:r.pdf
au BufRead,BufNewFile *.dot set makeprg=dot\ -Tpng\ %\ -o\ %:r.png

if system("which imv-wayland") == ""
    au BufRead,BufNewFile *.dot nnoremap <LocalLeader>v :w<CR>:execute "!sh -c \"imv '%:r.png' &\""<CR>
else
    au BufRead,BufNewFile *.dot nnoremap <LocalLeader>v :w<CR>:execute "!sh -c \"imv-wayland '%:r.png' &\""<CR>
endif

au BufRead,BufNewFile *.md nnoremap <LocalLeader>s :lua vim.fn.execute("r!screen2vim " ..  vim.fn.expand("%:p") .. " attach")<CR>
au BufRead,BufNewFile *.md nnoremap <LocalLeader>a :lua vim.fn.execute("r!file2vim " ..  vim.fn.expand("%:p") .. " attach")<CR>

nnoremap <Leader>( t(l"pda(hda("pp
nnoremap <Leader>l :lua vim.diagnostic.setloclist()<CR>
" the leader f won't work with this, but the leader G will.
vnoremap <Leader>c "+y
"
nnoremap <Leader>v "+]p
"
"au BufRead,BufNewFile *.c,*.h set makeprg=gcc\ \"%\"
au BufRead,BufNewFile *.rkt,*.rktl  set filetype=racket
" insert a unicode lambda on C-\
"au filetype racket set makeprg=raco\ exe\ \"%\"

au BufRead,BufNewFile Jenkinsfile set syntax=groovy
au BufRead,BufNewFile *.go set tabstop=4 shiftwidth=4 noexpandtab makeprg=go\ build\ .
au BufRead,BufNewFile *.py set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p | set errorformat=%f:%l:\ %m
"au BufWritePre *.py execute ':Black'
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
au BufRead,BufNewFile *.clj nnoremap <LocalLeader>d i(util/dbg <Esc>l])a)<Esc>
au BufRead,BufNewFile *.clj nnoremap <LocalLeader>D bi(util/dbg <Esc>lea)<Esc>
au BufRead,BufNewFile *.tex set makeprg=pdflatex\ -halt-on-error\ --shell-escape\ -interaction=nonstopmode\ \"%\"
au BufRead,BufNewFile SConstruct,SConscript set makeprg=scons
au BufRead,BufNewFile *.rb set tabstop=2
au BufRead,BufNewFile *.rb set shiftwidth=2
au BufRead,BufNewFile *.pp set shiftwidth=2
"au BufRead,BufNewFile *.lisp lua clstart()
au BufRead,BufNewFile *.lisp nnoremap <LocalLeader>d i(print <Esc>l])a)<Esc>
au BufRead,BufNewFile *.lisp nnoremap <LocalLeader>D bi(print <Esc>lea)<Esc>
au BufWritePre *.lisp lua vim.lsp.buf.format()
"| inoremap <CR> <CR><esc>i

" https://github.com/preservim/vim-markdown/issues/390#issuecomment-578459147
"let g:vim_markdown_auto_insert_bullets=0
"let g:vim_markdown_new_list_item_indent=0
"au BufRead,BufNewfile *.md set tabstop=2 | set shiftwidth=2 | setlocal formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[*+~-]\\s\\+\\\|^\\(\\\|[*#]\\)\\[^[^\\]]\\+\\]:\\s | setlocal comments=n:> | setlocal formatoptions+=cn

"https://github.com/preservim/vim-markdown/issues/390#issuecomment-450392655
"https://github.com/preservim/vim-markdown/pull/375
"| setlocal comments=bf:>,bf:*,bf:+,bf:- | set formatoptions+=c  | set formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[#*+~-]\\s\\+\\\|^\\(\\\|[*#-~+]\\)\\[^[^\\]]\\+\\]:\\s
au BufRead,BufNewFile *.md set shiftwidth=2 | set tabstop=2 | setlocal comments=bf:*,bf:+,bf:-,n:> | set formatoptions+=c  | set formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[#*+~-]\\s\\+\\\|^\\(\\\|[*#-~+]\\)\\[^[^\\]]\\+\\]:\\s | set textwidth=80 | set autoindent

au BufRead,BufNewFile *.hs set shiftwidth=2 | set tabstop=2
au BufRead,BufNewFile *.mtn set tabstop=8 | set shiftwidth=8 | set noexpandtab
au BufRead,BufNewFile *.tsv set tabstop=8 | set shiftwidth=8 | set noexpandtab
au BufRead,BufNewFile *.eml set colorcolumn=75 | map <LocalLeader>m :r!get-message-id %<CR>
autocmd TermOpen * setlocal nospell
au BufWritePost *.tf !terraform fmt %

" make pretty formatted use of variables
"au filetype sh map! $$ ${}OD
" enclose any variable within a line in quotes
"au filetype sh map \" :.s/\v(^\|[[:blank:]])(\$[^[:blank:]]*)([[:blank:]]\|$)/\1"\2"\3/g



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
    au BufRead,BufNewFile *.clj nnoremap <LocalLeader>j :call VSCodeNotify('calva.jackIn')<CR>
    au BufRead,BufNewFile *.clj noremap <LocalLeader>q :call VSCodeNotify('calva.disconnect')<CR>
    au BufRead,BufNewFile *.clj noremap <LocalLeader>f :call VSCodeNotify('calva.loadFile')<CR>
    au BufRead,BufNewFile *.clj noremap <LocalLeader>n :call VSCodeNotify('calva.loadNamespace')<CR>
    au BufRead,BufNewFile *.clj noremap <LocalLeader>s :call VSCodeNotify('calva.evaluateSelection')<CR>
    au BufRead,BufNewFile *.clj noremap <LocalLeader>C :call VSCodeNotify('calva.evaluateCurrentTopLevelForm')<CR>
endif

let g:vlime_cl_impl = "ros"

function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
    return ["/home/skin/.local/bin/ros", "run",
              \ "--load", a:vlime_loader,
              \ "--eval", a:vlime_eval]
endfunction

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gg=G')
endfunction

au BufRead,BufNewFile *.lisp compiler roswell-sbcl
"au BufWritePre *.lisp call Indent()"
au BufRead,BufNewFile *.asd compiler roswell-sbcl
au BufRead,BufNewFile *.ly nnoremap <LocalLeader>p :!timidity output/%:r.midi<CR>
au BufRead,BufNewFile *.ly nnoremap <LocalLeader>v :!zathura output/%:r.pdf &<CR>
"au BufRead,BufNewFile *.ly set makeprg=lilypond\ --formats=midi,pdf\ %

