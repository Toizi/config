if (has("termguicolors"))
  set termguicolors
endif


call plug#begin()

Plug 'tomasiser/vim-code-dark'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" enable ruler
set colorcolumn=80

syntax enable
colorscheme codedark

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" only search case sensitive if at least one char is upper case
set ignorecase
set smartcase

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "python", "bash", "html", "lua", "javascript"},
                      -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {  },        -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },              -- list of languages that will be disabled
  },
}
EOF
