set nocompatible
set background=dark
set number
set incsearch
set wildmenu
set nobackup
set smartindent

au BufReadPost,BufNewFile *.md set spell
set tw=79
colorscheme eink

" Removes trailing spaces
function! TrimWhiteSpace()
	%s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()
