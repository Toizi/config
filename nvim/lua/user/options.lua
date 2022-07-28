
local options = {
    -- clipboard = "unnamedplus",
    cmdheight = 2,
    colorcolumn = "80",
    completeopt = { "menuone", "noselect" },
    cursorline = true,
    expandtab = true,
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    number = true,
    relativenumber = false,
    scrolloff = 3,
    shiftround = true,
    shiftwidth = 4,
    showtabline = 2,
    sidescrolloff = 5,
    signcolumn = 'yes',
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = false,
    timeoutlen = 500,
    undofile = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
