-- wrap the original on_attach function and apply additional changes
local function on_attach_wrapper(client, bufnr)
    local original_on_attach = require("user.lsp.handlers").on_attach
    original_on_attach(client, bufnr)

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<cmd>lua require('rust-tools.inlay_hints').toggle_inlay_hints()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>le", "<cmd>lua require('rust-tools.expand_macro').expand_macro()<CR>", opts)
end

return {
  server = {
    on_attach = on_attach_wrapper,
    capabilities = require("user.lsp.handlers").capabilities,
  }
}
