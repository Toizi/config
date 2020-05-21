if (has("termguicolors"))
  set termguicolors
endif


call plug#begin()

Plug('tomasiser/vim-code-dark')

call plug#end()

syntax enable
colorscheme codedark

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

set ignorecase
set smartcase
