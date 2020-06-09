if (has("termguicolors"))
  set termguicolors
endif


call plug#begin()

Plug('tomasiser/vim-code-dark')

call plug#end()

" enable ruler
set colorcolumn=80

syntax enable
colorscheme codedark

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" search option to only search case sensitive if at least one char is
" captialized
set ignorecase
set smartcase
