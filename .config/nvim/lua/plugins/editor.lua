-- Editing helpers: file explorer, auto-pairs, surround, TODO comments
return {
  {
    -- Edit directories like a buffer: renaming a file = changing a line
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- must be able to replace netrw
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
    opts = {}, -- sa = add, sd = delete, sr = replace
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
    -- f/t across lines + jump labels with s
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash-Sprung" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter-Auswahl" },
    },
  },
}
