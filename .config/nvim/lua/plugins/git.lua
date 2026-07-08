-- Git: Änderungen im Gutter, Hunks stagen/verwerfen (Lazygit liegt in ui.lua bei snacks)
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end
        -- Ö/Ä analog zu ö/ä bei Diagnostics
        bmap("n", "Ä", function() gs.nav_hunk("next") end, "Nächster Git-Hunk")
        bmap("n", "Ö", function() gs.nav_hunk("prev") end, "Voriger Git-Hunk")
        bmap("n", "<leader>gs", gs.stage_hunk, "Hunk stagen (nochmal = unstagen)")
        bmap("n", "<leader>gr", gs.reset_hunk, "Hunk verwerfen")
        bmap("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Auswahl stagen")
        bmap("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Auswahl verwerfen")
        bmap("n", "<leader>gp", gs.preview_hunk, "Hunk-Vorschau")
        bmap("n", "<leader>gd", gs.diffthis, "Diff gegen Index")
      end,
    },
  },
}
