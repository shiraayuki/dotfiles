local opt = vim.opt

-- Leader must be set before lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lines & appearance
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " " }
opt.colorcolumn = "80" -- subtle line at 80 chars, purely visual
opt.winborder = "rounded"

-- Indentation (Python default; clangd/clang-format handle C/C++)
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Behavior
opt.clipboard = "unnamedplus" -- Wayland via wl-clipboard
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.confirm = true
opt.mouse = "a"
opt.completeopt = { "menu", "menuone", "noselect" }
