return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.inlay_hints.enabled = false
    -- workaround for gopls not working for files with build tags like //go:build integration
    opts.servers.gopls.settings.gopls.buildFlags = { "-tags=integration" }
  end,
}
