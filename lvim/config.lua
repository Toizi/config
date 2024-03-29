--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

-- reference example config
-- ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua

-- general
lvim.log.level = "warn"
lvim.format_on_save = false

-- lvim.colorscheme = "vsdark"
-- lvim.colorscheme = "ayu"
lvim.colorscheme = "vscode"
vim.opt.background = "light"

-- don't use system clipboard for all yank operations
vim.opt.clipboard = ""
-- show ruler at 80 chars
vim.opt.colorcolumn = "80"
-- show trailing whitepace and tabs
vim.cmd([[
set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,trail:★,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,trail:?,extends:>,precedes:<,nbsp:.'
endif
]])

-- don't insert a newline at the end of the file on write since some linters
-- flag that as an issue
vim.opt.fixeol = false

-- modify which keys go to start/end of next line
vim.opt.whichwrap = "[,],b,s"

-- cmp (auto-completion) config
local cmp = require("cmp")
-- disable always-on text preview for auto-completion
lvim.builtin.cmp.experimental.ghost_text = false

-- custom completion bindings
--   remove super-tab functionality
--   C-l for completion
--   C-b for scrolling docs
local jumpable = require("lvim.core.cmp").methods.jumpable
local luasnip = require("luasnip")
lvim.builtin.cmp.mapping = cmp.mapping.preset.insert({
  ["<C-l>"] = cmp.mapping.confirm { select = true },
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-y>"] = cmp.mapping {
    i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
    c = function(fallback)
      if cmp.visible() then
        cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
      else
        fallback()
      end
    end,
  },
  ["<Tab>"] = cmp.mapping(function(fallback)
    if jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.abort(),
  ["<CR>"] = cmp.mapping.confirm { select = false },
})

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- custom keymappings
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.vmappings["y"] = { "\"+y", "Copy to clipboard" }

-- unmap default keymappings
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false
lvim.keys.insert_mode["kk"] = false

-- Telescope config
local actions = require("telescope.actions")
-- see :h telescope.layout
lvim.builtin.telescope.defaults.layout_config = {
  -- prompt_position = "top",
  height = 0.9,
  width = 0.9,
  bottom_pane = {
    height = 25,
    preview_cutoff = 100,
  },
  center = {
    height = 0.4,
    preview_cutoff = 40,
    width = 0.5,
  },
  cursor = {
    preview_cutoff = 40,
  },
  horizontal = {
    preview_cutoff = 100,
    preview_width = 0.5,
  },
  vertical = {
    preview_cutoff = 40,
  },
  flex = {
    flip_columns = 150,
  },
}

for key, _ in pairs(lvim.builtin.telescope.pickers) do
  if key ~= "planets" then
    lvim.builtin.telescope.pickers[key].previewer = nil
    lvim.builtin.telescope.pickers[key].theme = nil
    lvim.builtin.telescope.pickers[key].layout_strategy = nil
  end
end

-- default is "smart" which often cuts off way too much of the path to distinguish
-- files with the same name
lvim.builtin.telescope.defaults.path_display = { "truncate" }
-- flex means it will either use horizontal or vertical, depending on the window width
lvim.builtin.telescope.defaults.layout_strategy = "flex"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev

lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
lvim.builtin.telescope.defaults.mappings.i["<esc>"] = actions.close

-- Open references in telescope instead of the quickfix window
-- show_line only shows the filename and not the match since we always have a preview anyway
lvim.lsp.buffer_mappings.normal_mode["gr"] = { ":lua require('telescope.builtin').lsp_references({show_line=false})<cr>", "References (telescope)" }
lvim.lsp.buffer_mappings.normal_mode["gi"] = { ":lua require('telescope.builtin').lsp_implementations({show_line=false})<cr>", "References (telescope)" }
lvim.lsp.buffer_mappings.normal_mode["gR"] = { vim.lsp.buf.references, "References (Quick fix)" }

-- Quick access to search through open buffers
lvim.builtin.which_key.mappings["o"] = { "<cmd>Telescope buffers initial_mode=insert previewer=false theme=dropdown<cr>", "Find buffer" }

-- Diffview shortcuts
lvim.builtin.which_key.mappings["g"]["h"] = { "<cmd>DiffviewFileHistory %<cr>", "Diff view current file history" }
lvim.builtin.which_key.mappings["g"]["q"] = { "<cmd>DiffviewClose<cr>", "Diff view close" }

-- Show suggestions for folding
lvim.builtin.which_key.setup.plugins.presets.z = true
vim.opt.foldmethod = "expr" -- default is "normal"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldenable = false -- don't fold when opening document

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- treesitter config
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "go",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

vim.diagnostic.config({
  -- lsp config
  underline = false,
  -- disable inline diagnostics
  virtual_text = false,
})

-- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
vim.api.nvim_create_augroup("lvim_user", {})
lvim.autocommands = {
  {
    { "BufEnter", "BufWinEnter" },
    {
      group = "lvim_user",
      pattern = "*.rs",
      command = "setlocal ts=4 sw=4",
    },
  },
}

-- setup rust
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
lvim.plugins = {
  { "Mofiqul/vscode.nvim", },
  { "sindrets/diffview.nvim", },
  { "tpope/vim-sleuth" },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
    config = function()
      require("rust-tools").setup {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = "rounded",

            auto_focus = true,
          },
          on_initialized = function()
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
              pattern = { "*.rs" },
              callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
              end,
            })
          end,
        },
        server = {
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require "rust-tools"
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
          end,
          capabilities = require("lvim.lsp").common_capabilities(),
          settings = {
            ["rust-analyzer"] = {
              lens = {
                enable = true,
              },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--all", "--", "-W", "clippy::all" },
              },
              rustfmt = {
                extraArgs = { "+nightly" },
              },
              procMacro = {
                enable = true,
              }
            },
          },
        },
      }
    end,
  },
}

-- turn off automatic pair insertion
table.insert(lvim.builtin.autopairs.disable_filetype, "markdown")

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
