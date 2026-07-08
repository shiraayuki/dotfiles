-- Neovim config for Python & C/C++
-- Layout:
--   lua/config/   → options, keymaps, autocmds, plugin manager bootstrap
--   lua/plugins/  → one file per topic, loaded by lazy.nvim

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
