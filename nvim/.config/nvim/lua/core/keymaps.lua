local Util = require("util")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

vim.keymap.set("n", "<Esc>", function()
	Util.close_floats()
end, { desc = "Close floats" })
