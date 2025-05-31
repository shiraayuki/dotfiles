require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright", -- Python
		"ts_ls", -- TypeScript / React
		"rust_analyzer", -- Rust
		"clangd", -- C++
		"kotlin_language_server", -- Kotlin
	},
})
