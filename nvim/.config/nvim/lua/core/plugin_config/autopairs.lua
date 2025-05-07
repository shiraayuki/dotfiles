require("nvim-autopairs").setup()

vim.api.nvim_create_autocmd("User", {
  pattern = "VimtexEventCompileSuccess",
  callback = function()
    vim.fn.jobstart({ "latexmk", "-c" }, { detach = true })
  end,
})
