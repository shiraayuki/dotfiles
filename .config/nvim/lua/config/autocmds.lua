local aug = function(name)
  return vim.api.nvim_create_augroup("nikolas_" .. name, { clear = true })
end

-- Kopierten Text kurz hervorheben
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug("yank"),
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

-- Cursor-Position beim Öffnen wiederherstellen
vim.api.nvim_create_autocmd("BufReadPost", {
  group = aug("restore_cursor"),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lines = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- C/C++: 2er-Einrückung ist Geschmackssache — Kernel-Style wäre 8, LLVM 2.
-- Wir bleiben bei 4 (Default), clang-format entscheidet eh beim Formatieren.

-- Bestimmte Fenster mit q schließen
vim.api.nvim_create_autocmd("FileType", {
  group = aug("close_with_q"),
  pattern = { "help", "qf", "checkhealth", "man", "notify" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})
