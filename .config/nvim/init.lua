-- Neovim-Config für Python & C/C++
-- Struktur:
--   lua/config/   → Optionen, Keymaps, Autocmds, Plugin-Manager-Bootstrap
--   lua/plugins/  → ein File pro Themenbereich, wird von lazy.nvim geladen

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
