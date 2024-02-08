" Vim color file
" Maintainer: Daniel Haskin <djhaskin987@gmail.com>
" Last Change: 2011 October 26

" rainbow brite -- for those who prefer dark background with bright colors

"set bg=light
hi clear
if exists("syntax_on")
 syntax reset
endif

let g:colors_name = "simple"

hi clear ErrorMsg
hi clear ColorColumn
hi clear TODO
hi clear VisualNOS
hi clear IncSearch
hi clear Folded
hi clear Repeat
hi clear Operator
hi clear Keyword
hi clear Label
hi clear Function
hi clear String
hi clear Character
hi clear Number
hi clear Boolean
hi clear Float
hi clear Conditional
hi clear Exception
hi clear Include
hi clear Define
hi clear Macro
hi clear PreCondit
hi clear StorageClass
hi clear Structure
hi clear Typedef
hi clear Tag
hi clear SpecialChar
hi clear Delimiter
hi clear SpecialComment
hi clear Debug


if (&bg == "light")
    hi Normal  guibg=#ffffff guifg=#000000 ctermfg=black ctermbg=white
    hi Error term=underline guifg=#ff0000 guibg=#ffffff ctermfg=red ctermbg=white gui=underline cterm=underline
    hi Visual  gui=reverse cterm=reverse
    hi Search  guibg=#f8f888 guifg=#0000ff ctermbg=lightblue ctermfg=blue cterm=bold term=bold
    hi Folded guifg=#c0c0c0 guibg=#ffffff   ctermfg=lightgrey ctermbg=white cterm=bold term=bold

    "gui=bold cterm=bold

    hi Comment          guifg=#808080 ctermfg=darkgrey cterm=bold gui=bold
    hi Special          guifg=#000000 ctermfg=black cterm=bold gui=bold
    hi PreProc          guifg=#8080ff ctermfg=lightblue
    hi Type             guifg=#008000 ctermfg=darkgreen
    hi Statement        guifg=#804000 ctermfg=brown
    hi Constant         guifg=#800080 ctermfg=darkmagenta
    hi Operator         guifg=#ff0000 ctermfg=red
    hi Identifier       guifg=#0000ff ctermfg=blue
    hi ColorColumn      guifg=#ff0000 ctermfg=red cterm=bold gui=bold
    hi Delimiter        guifg=#000080 ctermfg=darkblue cterm=bold gui=bold

    " suggested by tigmoid, 2008 Jul 18
    hi Pmenu guibg=#c0c0c0 guifg=#404080
    hi PmenuSel guibg=#c0c0c0 guifg=#2050d0
    hi PmenuSbar guibg=blue guifg=darkgray
    hi PmenuThumb guibg=#c0c0c0 guifg=#ffffff
else
    hi Normal  guifg=#ffffff guibg=#000000 ctermfg=white
    hi Error term=underline guifg=#ff0000 guibg=#000000 ctermfg=red ctermbg=black gui=underline cterm=underline
    hi Visual  gui=reverse cterm=reverse
    hi Search  guifg=#f8f888 guibg=#0000ff ctermfg=lightblue ctermbg=blue cterm=bold term=bold
    hi Folded guifg=#808080 guibg=#404040   ctermfg=darkgrey ctermbg=black cterm=bold term=bold

    "gui=bold cterm=bold

    hi Comment          guifg=#c0c0c0 ctermfg=lightgrey cterm=bold gui=bold
    hi Special          guifg=#ffffff ctermfg=white cterm=bold gui=bold
    hi PreProc          guifg=#80ff80 ctermfg=lightgreen
    hi Type             guifg=#00ff00 ctermfg=green
    hi Statement        guifg=#ffff00 ctermfg=yellow
    hi Constant         guifg=#ff00ff ctermfg=magenta
    hi Operator         guifg=#ff0000 ctermfg=red
    hi Identifier       guifg=#00c0c0 ctermfg=darkcyan
    hi ColorColumn      guifg=#ff0000 ctermfg=red cterm=bold gui=bold
    hi Delimiter        guifg=#8080ff ctermfg=lightblue cterm=bold gui=bold

    " suggested by tigmoid, 2008 Jul 18
    hi Pmenu guifg=#c0c0c0 guibg=#404080
    hi PmenuSel guifg=#c0c0c0 guibg=#2050d0
    hi PmenuSbar guifg=blue guibg=darkgray
    hi PmenuThumb guifg=#c0c0c0
endif

hi link ErrorMsg Error
hi link TODO Error
hi link VisualNOS Visual
hi link IncSearch Search
hi link Folded FoldColumn
hi link Repeat Statement
hi link Keyword Statement
hi link Label Identifier
hi link Function Identifier
hi link String Constant
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi link Conditional Repeat
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Identifier
hi link SpecialChar Special
hi link SpecialComment Special
hi link Debug  Special

" cursorline, but bold not underlined
highlight clear CursorLine
highlight CursorLine gui=bold cterm=bold
highlight clear cursorline
highlight cursorline gui=bold cterm=bold
