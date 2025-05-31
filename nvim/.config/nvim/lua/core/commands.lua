local util = require("util")

vim.api.nvim_create_user_command("BuildInstall", function()
	util.build_and_install()
end, {})
