local lspconfig = require("lspconfig")

local servers = { "pyright", "ts_ls", "rust_analyzer", "clangd" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }
end
