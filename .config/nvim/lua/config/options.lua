local opt = vim.opt

-- Leader muss vor lazy.nvim gesetzt sein
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Zeilen & Darstellung
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
opt.colorcolumn = "80" -- dezente Linie bei 80 Zeichen, rein visuell
opt.winborder = "rounded"

-- Einrückung (Python-Standard, clangd/clang-format regeln C/C++)
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

-- Suche
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Verhalten
opt.clipboard = "unnamedplus" -- Wayland via wl-clipboard
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.confirm = true
opt.mouse = "a"
opt.completeopt = { "menu", "menuone", "noselect" }
