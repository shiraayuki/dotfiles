local aug = function(name)
  return vim.api.nvim_create_augroup("nikolas_" .. name, { clear = true })
end

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug("yank"),
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

-- Restore cursor position when reopening a file
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

-- C/C++: 2-space indent is a matter of taste — kernel style would be 8, LLVM 2.
-- We stay at 4 (default); clang-format decides when formatting anyway.

-- Close certain windows with q
vim.api.nvim_create_autocmd("FileType", {
  group = aug("close_with_q"),
  pattern = { "help", "qf", "checkhealth", "man", "notify" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})
