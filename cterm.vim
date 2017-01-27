" only use base 16 colors for highlighting; works great with most custom
" colorschemes. Thanks to https://github.com/Jarvvski for the basis of this.
hi clear
if exists("syntax_on")
     syntax reset
endif
let colors_name = "cterm"

hi javaRepeat ctermfg = green
hi javaType ctermfg = green
hi javaStorageClass ctermfg = green cterm=bold
hi javaDocTags ctermfg = green
hi Conditional ctermfg = green
hi LineNr ctermfg = magenta
hi Comment ctermfg = red
hi Statement ctermfg = blue
hi Function ctermfg = blue
hi Identifier ctermfg = blue
hi Exception ctermfg = green
hi Special ctermfg = green
hi String ctermfg = yellow
hi MatchParen ctermbg=none cterm=bold ctermfg=none
