local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "pyright",
  "ts_ls",
  "rust_analyzer",
  "clangd",
  "gopls",
  "kotlin_language_server",
}

-- gopls extra settings
vim.lsp.config("gopls", {
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
})

-- alle anderen (nur capabilities)
for _, server in ipairs(servers) do
  if server ~= "gopls" then
    vim.lsp.config(server, {
      capabilities = capabilities,
    })
  end
end

-- aktivieren (wichtig!)
vim.lsp.enable(servers)
