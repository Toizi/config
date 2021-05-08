" Does not seem required anymore and can break tmux colors
" if (has("termguicolors"))
"   set termguicolors
" endif


call plug#begin()

" theme
Plug 'tomasiser/vim-code-dark'

" advanced syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" toggle comments using v_gc or gcc
Plug 'tpope/vim-commentary'

" file manager
Plug 'lambdalisue/fern.vim'

call plug#end()

" enable ruler
set colorcolumn=80

" enable syntax highlighting
syntax enable

" theme
colorscheme codedark

" enable line numbers
set number

" always keep num lines between cursor and buffer end
set scrolloff=3

set tabstop=4         " tab size
set expandtab         " tabs to spaces
set shiftwidth=4      " width for autoindents
set autoindent        " automatically indent based on previous line

" enable mouse in basically all modes
set mouse=a

" map ctrl + backspace to delete last word in insert/cli mode
noremap! <C-BS> <C-w>

" only search case sensitive if at least one char is upper case
set ignorecase
set smartcase

" .............................................................................
" nvim-treesitter/nvim-treesitter
" .............................................................................
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

" .............................................................................
" lambdalisue/fern.vim
" .............................................................................

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 0

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! s:init_fern() abort
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> t <Plug>(fern-action-mark)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> <C-l> <Plug>(fern-action-enter)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
