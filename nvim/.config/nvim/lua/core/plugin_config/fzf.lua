require("fzf-lua").setup {
  winopts = {
    height = 0.85,
    width  = 0.80,
    row    = 0.30,
    col    = 0.50,
    border = 'rounded',
    preview = {
      layout = 'vertical',
      vertical = 'down:45%',
    },
  },
  files = {
    prompt = '🔍 ',
    git_icons = true,
    file_icons = true,
  },
  grep = {
    prompt = '🔎 Grep> ',
  },
}

-- Keymaps
local map = vim.keymap.set
local fzf = require('fzf-lua')

map('n', '<C-p>', fzf.files, {})                -- Dateisuche
map('n', '<Space><Space>', fzf.buffers, {})     -- Geöffnete Buffers
map('n', '<Space>fg', fzf.live_grep, {})        -- Textsuche (live grep)
map('n', '<Space>fh', fzf.help_tags, {})        -- Hilfe durchsuchen
map('n', '<Space>fr', fzf.oldfiles, {})         -- Zuletzt geöffnete Dateien
map('n', '<Space>gs', fzf.git_status, {})       -- git status (changed files)
map('n', '<Space>gc', fzf.git_commits, {})      -- git commits
