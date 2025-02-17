" Vim color file
" Maintainer:	Daniel Haskin <djhaskin987@gmail.com>
" Last Change:	2011 October 26

" rainbow brite -- for those who prefer dark background with bright colors

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "rainbow_brite"

hi Normal		guifg=#ffffff guibg=#000000	ctermfg=white
hi ErrorMsg		guifg=#ffffff guibg=#ff0000	ctermfg=white ctermbg=red
hi Visual		gui=reverse cterm=reverse
hi VisualNOS	gui=reverse cterm=reverse
hi Search		guifg=#ffffff guibg=#0000ff ctermfg=white ctermbg=blue cterm=bold term=bold
hi IncSearch	guifg=#ffffff guibg=#0000ff ctermfg=white ctermbg=blue cterm=bold term=bold

hi Folded	guifg=#808080 guibg=#404040			ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi FoldColumn	guifg=#808080 guibg=#404040			ctermfg=darkgrey ctermbg=black cterm=bold term=bold

hi Constant         guifg=#4000ff ctermfg=darkblue

hi SpecialChar      guifg=#8000ff ctermfg=darkmagenta
hi Character        guifg=#c000ff ctermfg=lightmagenta
hi String           guifg=#ff00ff ctermfg=magenta

hi Float            guifg=#ff00c0 ctermfg=lightred
hi Number           guifg=#ff0080 ctermfg=red
hi Boolean          guifg=#ff0040 ctermfg=darkred


hi PreProc          guifg=#ff0000 ctermfg=green
hi PreCondit        guifg=#ff4000 ctermfg=darkgreen
hi Include          guifg=#ff8000 ctermfg=lightgreen

hi Repeat           guifg=#ffc000 ctermfg=yellow
hi Conditional      guifg=#ffff00 ctermfg=yellow
hi Statement        guifg=#c0ff00 ctermfg=yellow
hi Operator         guifg=#80ff00 ctermfg=darkyellow
hi StorageClass     guifg=#40ff00 ctermfg=darkyellow
hi Label            guifg=#00ff00 ctermfg=green

hi TODO             guifg=#000000 guibg=#08ff04 ctermfg=black ctermbg=lightgreen
hi Comment          guifg=#c0c0c0 ctermfg=lightgrey
hi Error            guifg=#000000 guibg=#ff0404 ctermfg=black ctermbg=lightred
hi SpecialComment   guifg=#aaaaaa ctermfg=grey


hi Type             guifg=#00ffc0 ctermfg=lightcyan
hi Structure        guifg=#00ffff ctermfg=cyan
hi Function         guifg=#00c0ff ctermfg=darkcyan
hi Identifier       guifg=#0080ff ctermfg=lightblue
hi Macro            guifg=#0040ff ctermfg=blue
" Not using: 0000ff, 00ff40,00ff80

" suggested by tigmoid, 2008 Jul 18
hi Pmenu guifg=#c0c0c0 guibg=#404080
hi PmenuSel guifg=#c0c0c0 guibg=#2050d0
hi PmenuSbar guifg=blue guibg=darkgray
hi PmenuThumb guifg=#c0c0c0
