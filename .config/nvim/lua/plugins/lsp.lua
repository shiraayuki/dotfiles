-- LSP: clangd (C/C++), basedpyright + ruff (Python), lua_ls (für die Config selbst)
-- Server werden über Mason installiert und von mason-lspconfig automatisch aktiviert.
return {
  {
    "mason-org/mason.nvim",
    opts = { ui = { border = "rounded" } },
  },
  {
    -- installiert Tools, die keine LSP-Server sind (Formatter, Debugger)
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "clang-format", "stylua", "codelldb", "debugpy",
        "prettierd", "gofumpt", "goimports", "shfmt", "shellcheck",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Capabilities von blink.cmp an alle Server geben
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders=false",
        },
      })

      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard", -- "strict" wäre für den Anfang nervig
            },
          },
        },
      })

      vim.lsp.config("ruff", {
        -- Hover macht basedpyright, ruff nur Linting/Code-Actions
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      })

      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            analyses = { unusedparams = true },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" }, -- Clippy-Lints statt nur cargo check
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", "basedpyright", "ruff", "lua_ls",
          "ts_ls", "gopls", "rust_analyzer",
          "jdtls", "kotlin_language_server",
          "bashls", "jsonls", "yamlls",
        },
      })

      -- Diagnostics-Optik
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = { spacing = 2, prefix = "●" },
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
      })

      -- Keymaps, sobald ein LSP am Buffer hängt
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("nikolas_lsp", { clear = true }),
        callback = function(ev)
          local function bmap(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          bmap("n", "gd", function() Snacks.picker.lsp_definitions() end, "Definition")
          -- IDE-Style: Strg+Klick springt zur Definition, zurück mit Strg+O
          bmap("n", "<C-LeftMouse>", "<LeftMouse><cmd>lua vim.lsp.buf.definition()<cr>", "Definition (Strg+Klick)")
          bmap("n", "gD", vim.lsp.buf.declaration, "Deklaration")
          bmap("n", "grr", function() Snacks.picker.lsp_references() end, "Referenzen")
          bmap("n", "gri", function() Snacks.picker.lsp_implementations() end, "Implementierungen")
          bmap("n", "grt", function() Snacks.picker.lsp_type_definitions() end, "Typ-Definition")
          bmap("n", "gO", function() Snacks.picker.lsp_symbols() end, "Symbole im Buffer")
          bmap("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover-Doku")
          bmap("n", "grn", vim.lsp.buf.rename, "Umbenennen")
          bmap({ "n", "v" }, "gra", vim.lsp.buf.code_action, "Code-Action")
          -- clangd: zwischen Header und Source springen
          bmap("n", "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", "Header ↔ Source")

          -- Inlay-Hints (Typen inline anzeigen) umschaltbar
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            bmap("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, "Inlay-Hints umschalten")
          end
        end,
      })
    end,
  },
}
