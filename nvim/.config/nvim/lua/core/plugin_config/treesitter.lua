require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "rust", "vim", "html", "javascript", "typescript", "vue" },

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
