local opt = vim.opt

-- I like relative line numbers
opt.number = true
opt.relativenumber = true

-- Make tabs sensible
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Search improvements
opt.hlsearch = false
opt.incsearch = true

-- We want full color support
opt.termguicolors = true

opt.scrolloff = 8
opt.updatetime = 50
opt.colorcolumn = "100"

-- Make undo persistent
opt.undofile = true

opt.signcolumn = "yes"

vim.g.mapleader = " "
vim.g.leaderkey = " "
