-- Looks & QoL: snacks.nvim (dashboard, picker, notifications, …), lualine, bufferline
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
      words = { enabled = true }, -- highlight occurrences of the word under the cursor
      terminal = {},
      lazygit = {},
    },
    keys = {
      -- Pickers (fuzzy finder)
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Files (smart)" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (project)" },
      { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Search word under cursor", mode = { "n", "x" } },
      -- Terminal & Git
      { "<C-t>", function() Snacks.terminal() end, desc = "Terminal", mode = { "n", "t" } },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Blame line" },
      -- Misc
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Hide notifications" },
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
        offsets = { { filetype = "oil", text = "Files" } },
      },
    },
    config = function(_, opts)
      -- Catppuccin ships ready-made bufferline highlights (under special.* since v1.10)
      opts.highlights = require("catppuccin.special.bufferline").get_theme()
      require("bufferline").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>d", group = "Debug" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>t", group = "Toggle" },
        { "<leader>u", group = "UI" },
      },
    },
  },
}
