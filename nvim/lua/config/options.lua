-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false

local opt = vim.opt

opt.relativenumber = false
opt.clipboard = ""
opt.background = "light"

-- don't do any animations
vim.g.snacks_animate = false