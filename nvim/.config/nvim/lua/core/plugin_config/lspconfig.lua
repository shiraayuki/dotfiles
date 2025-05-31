local lspconfig = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "pyright", "ts_ls", "rust_analyzer", "clangd", "gopls", "kotlin_language_server" }

for _, server in ipairs(servers) do
	if server == "gopls" then
		lspconfig.gopls.setup({
			capabilities = capabilities,
			settings = {
				gopls = {
					gofumpt = true,
					usePlaceholders = true,
					completeUnimported = true,
				},
			},
		})
	else
		lspconfig[server].setup({
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end
end
