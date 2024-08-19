return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "solidity" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "nomicfoundation-solidity-language-server" } },
  },
}
