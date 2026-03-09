return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "solidity" } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "nomicfoundation-solidity-language-server" } },
  },
}
