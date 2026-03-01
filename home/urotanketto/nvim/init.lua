-- Basic options
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.signcolumn = "yes"

-- Enable truecolor only on terminals that can handle it well
local term = vim.env.TERM or ""
local colorterm = vim.env.COLORTERM or ""

if term ~= "linux" and (colorterm ~= "" or term:find("256color")) then
  vim.opt.termguicolors = true
else
  vim.opt.termguicolors = false
end

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
