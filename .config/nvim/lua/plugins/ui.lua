-- Optik & QoL: snacks.nvim (Dashboard, Picker, Notifications, …), lualine, bufferline
return {
  {
    "folke/snacks.nvim",
    priority = 900,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
            "████╗  ██║██║   ██║██║████╗ ████║",
            "██╔██╗ ██║██║   ██║██║██╔████╔██║",
            "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
          }, "\n"),
        },
      },
      picker = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      indent = { enabled = true },
      scroll = { enabled = true },
      bigfile = { enabled = true },
      statuscolumn = { enabled = true },
      input = { enabled = true },
      words = { enabled = true }, -- Vorkommen des Worts unterm Cursor markieren
      terminal = {},
      lazygit = {},
    },
    keys = {
      -- Picker (Fuzzy-Finder)
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Dateien (smart)" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Dateien" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live-Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffer" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Zuletzt geöffnet" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Hilfe" },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnosen (Projekt)" },
      { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Wort unterm Cursor suchen", mode = { "n", "x" } },
      -- Terminal & Git
      { "<C-t>", function() Snacks.terminal() end, desc = "Terminal", mode = { "n", "t" } },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Blame für Zeile" },
      -- Sonstiges
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Notifications ausblenden" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin-mocha",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics", "lsp_status", "filetype" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "oil", text = "Dateien" } },
      },
    },
    config = function(_, opts)
      -- Catppuccin liefert fertige Bufferline-Highlights (seit v1.10 unter special.*)
      opts.highlights = require("catppuccin.special.bufferline").get_theme()
      require("bufferline").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "Finden" },
        { "<leader>g", group = "Git" },
        { "<leader>d", group = "Debug" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>t", group = "Umschalten" },
        { "<leader>u", group = "UI" },
      },
    },
  },
}
