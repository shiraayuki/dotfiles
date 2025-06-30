local Util = {}

function Util.close_floats()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative == "win" then
			vim.api.nvim_win_close(win, false)
		end
	end
end

Util.build_and_install = function()
	local cwd = vim.fn.getcwd()
	local apk_path = cwd .. "/app/build/outputs/apk/debug/app-debug.apk"

	vim.fn.jobstart({ "./gradlew", "assembleDebug" }, {
		on_exit = function(_, exit_code, _)
			if exit_code == 0 then
				print("Build successfull, installing APK...")
				-- APK installieren
				vim.fn.jobstart({ "adb", "install", "-r", apk_path }, {
					on_exit = function(_, exit_code_install, _)
						if exit_code_install == 0 then
							print("App successfully insatlled!")
						else
							print("Error when installing app")
						end
					end,
				})
			else
				print("Build failed!")
			end
		end,
	})
end

Util.toggle_format_on_save = function()
  vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
  if vim.g.format_on_save_enabled then
    print("Format on Save: ENABLED")
  else
    print("Format on Save: DISABLED")
  end
end

return Util
