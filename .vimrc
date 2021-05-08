" Does not seem required anymore and can break tmux colors
" if (has("termguicolors"))
"   set termguicolors
" endif


call plug#begin()

Plug 'tomasiser/vim-code-dark'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" enable ruler
set colorcolumn=80

" enable syntax highlighting
syntax enable

" theme
colorscheme codedark

" enable line numbers
set number

set tabstop=4         " tab size
set expandtab         " tabs to spaces
set shiftwidth=4      " width for autoindents
set autoindent        " automatically indent based on previous line

" enable mouse in basically all modes
set mouse=a

" map ctrl + backspace/h to delete last word in insert/cli mode
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
