return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend(
        "force",
        opts.mapping,
        {
          -- don't accept autocompletion via enter
          ["<CR>"] = function(fallback) cmp.abort() fallback() end,
          -- accept autocompletion via ctrl+l instead
          ["<C-l>"] = cmp.mapping.confirm({ select = true }),
        }
      )
      -- turn off ghost text
      opts.experimental.ghost_text = nil
    end,
  },
}
