-- Treesitter (main-Branch, neue API ab nvim 0.11+)
-- Parser werden kompiliert → braucht einen C-Compiler (gcc/clang)!
local parsers = {
  "python", "c", "cpp", "cmake", "make",
  "lua", "vim", "vimdoc", "query",
  "bash", "json", "toml", "yaml",
  "markdown", "markdown_inline", "diff", "gitcommit",
  "javascript", "typescript", "tsx",
  "go", "gomod", "gosum",
  "rust", "java", "kotlin",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nikolas_treesitter", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
            -- Einrückung via Treesitter (Python profitiert deutlich)
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
