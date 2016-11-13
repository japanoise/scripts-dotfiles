set background=dark
set number
"only highlight comments
highlight clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "comments"

" First set Normal to regular white on black text colors:
hi Normal ctermfg=NONE ctermbg=NONE

" Syntax highlighting (other color-groups using default, see :help group-name):
hi Comment    cterm=NONE ctermfg=04
hi Constant   cterm=NONE ctermfg=None
hi Identifier cterm=NONE ctermfg=None
hi Function   cterm=NONE ctermfg=None
hi Statement  cterm=NONE ctermfg=None
hi PreProc    cterm=NONE ctermfg=None
hi Type	      cterm=NONE ctermfg=None
hi Special    cterm=NONE ctermfg=None
hi Delimiter  cterm=NONE ctermfg=None
"other nice options
set incsearch
set wildmenu
set nobackup
set smartindent

au BufReadPost,BufNewFile *.md set spell
set tw=79
