require("conform").setup({
      format_on_save = function(bufnr)
        local ignore_ft = {}
        if vim.tbl_contains(ignore_ft, vim.bo[bufnr].filetype) then
          return
        end
        return { timeout_ms = 1000, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        rust = { "rustfmt" },
        cpp = { "clang_format" },
        c = { "clang_format" },
      },
      formatters = {
        clang_format = {
          prepend_args = { "--style=Google" },
        },
        rustfmt = {
          prepend_args = { "--config", "edition=2021" },
        },
        black = {
          prepend_args = { "--line-length", "100" },
        },
        prettier = {
          prepend_args = {
            "--print-width", "100",
            "--tab-width", "2",
            "--single-quote",
            "--jsx-single-quote",
          },
        },
      },
    })
