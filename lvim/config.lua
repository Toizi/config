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

-- unmap default keymappings
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false
lvim.keys.insert_mode["kk"] = false

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.vmappings["y"] = { "\"+y", "Copy to clipboard" }

-- Open references in telescope instead of the quickfix window
lvim.lsp.buffer_mappings.normal_mode["gr"] = {  "<cmd>Telescope lsp_references<cr>", "References (telescope)" }
lvim.lsp.buffer_mappings.normal_mode["gR"] = {  vim.lsp.buf.references, "References (Quick fix)" }

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

-- setup rust
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
lvim.plugins = {
  -- contains both dark and light theme depending on the surroundings
  -- use `set background=light` to active light theme
  {"mg979/vim-studio-dark"},
  {
    "Shatur/neovim-ayu",
    config = function()
      -- change background colors of git diff to make it more readable on light
      -- theme
      require("ayu").setup({
        overrides = function()
          if vim.o.background == 'light' then
            return
              {
                -- DiffAdd = { fg = '#99BF4D', bg = '#E0E7CD'},
                -- DiffChange = { fg = '#709ECC' },
                -- DiffText = { fg = '#F27983', bg = '#F9EBE4'},
                --
                DiffAdd = { bg = '#f2ffe6'},
                DiffChange = { bg = '#F1FDFF'},
                DiffText = { bg = '#E4FCFF'},
              }
          end
          return {}
        end
      })
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    -- require("vscode").setup({

    -- })
  },
  {
   "simrat39/rust-tools.nvim",
    -- ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
    config = function()
      require("rust-tools").setup {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
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
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require "rust-tools"
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      }
    end,
  },
}

-- turn off automatic pair insertion
table.insert(lvim.builtin.autopairs.disable_filetype, "markdown")
