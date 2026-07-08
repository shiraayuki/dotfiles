-- Editier-Helfer: Datei-Explorer, Klammern, Surround, TODO-Kommentare
return {
  {
    -- Verzeichnisse wie einen Buffer editieren: Dateien umbenennen = Zeile ändern
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- muss netrw ersetzen können
    opts = {
      view_options = { show_hidden = true },
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Dateimanager (Verzeichnis drüber)" },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {}, -- sa = hinzufügen, sd = löschen, sr = ersetzen
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>ft", "<cmd>TodoQuickFix<cr>", desc = "TODOs im Projekt" },
    },
  },
  {
    -- f/t über Zeilen hinweg + Sprung-Labels mit s
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash-Sprung" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter-Auswahl" },
    },
  },
}
