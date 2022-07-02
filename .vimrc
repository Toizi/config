" Does not seem required anymore and can break tmux colors
" if (has("termguicolors"))
"   set termguicolors
" endif


call plug#begin()

" theme
Plug 'tomasiser/vim-code-dark'
Plug 'mg979/vim-studio-dark'

" advanced syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" language server configuration
Plug 'neovim/nvim-lspconfig'

" auto completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" toggle comments using v_gc or gcc
Plug 'tpope/vim-commentary'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" file manager
Plug 'lambdalisue/fern.vim'

" make sure latest version is installed
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" fzf integration
Plug 'junegunn/fzf.vim'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()

" enable ruler
set colorcolumn=80

" enable syntax highlighting
syntax enable

" theme
colorscheme vsdark

" enable line numbers
set number

" always keep num lines between cursor and buffer end
set scrolloff=3

set autoindent        " automatically indent based on previous line
set tabstop=4         " tab size
set expandtab         " tabs to spaces
set shiftwidth=4      " width for autoindents
set shiftround        " >> indents to multiple of 'shiftwidth'

" enable mouse in basically all modes
set mouse=a

" map ctrl + backspace to delete last word in insert/cli mode
noremap! <C-BS> <C-w>

" split windows
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" move between windows
map sh <C-w>h
map sj <C-w>j
map sk <C-w>k
map sl <C-w>l

" move windows
map s<left> <C-w>h
map s<down> <C-w>j
map s<up> <C-w>k
map s<right> <C-w>l

" move between tabs
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

" create tab
nmap te :tabedit

" only search case sensitive if at least one char is upper case
set ignorecase
set smartcase

" Show non-printable characters.
set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,trail:★,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,trail:?,extends:>,precedes:<,nbsp:.'
endif

" .............................................................................
" hrsh7th/nvim-cmp
" .............................................................................
lua <<EOF
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-l>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- C/C++ CLANGD
  require'lspconfig'.clangd.setup {
    capabilities = capabilities
  }

  -- PYTHON
  require'lspconfig'.pyright.setup {
    capabilities = capabilities
  }

  -- BASH
  require'lspconfig'.bashls.setup {
    capabilities = capabilities
  }

  -- SOLIDITY
  require'lspconfig'.solidity_ls.setup {
    capabilities = capabilities
  }

EOF

" Snippet config vsnip
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" .............................................................................
" neovim/nvim-lspconfig
" .............................................................................
" individual server setup happens in cmp setup

" GENERAL
set completeopt=menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" KEYBINDS
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> ge <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>

" FILETYPE ASSIGNMENT
au BufRead,BufNewFile *.sol setfiletype solidity
au BufRead,BufNewFile *.MD setfiletype markdown

" .............................................................................
" nvim-treesitter/nvim-treesitter
" .............................................................................
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "python", "bash", "html", "lua", "javascript",
                      "solidity", "markdown"},
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


" .............................................................................
" iamcco/markdown-preview
" .............................................................................
let g:mkdp_refresh_slow = 1

