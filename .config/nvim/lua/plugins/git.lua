-- Git: changes in the gutter, stage/discard hunks (lazygit lives in ui.lua with snacks)
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
        -- Ö/Ä mirror the ö/ä diagnostics keys
        bmap("n", "Ä", function() gs.nav_hunk("next") end, "Next git hunk")
        bmap("n", "Ö", function() gs.nav_hunk("prev") end, "Previous git hunk")
        bmap("n", "<leader>gs", gs.stage_hunk, "Stage hunk (again = unstage)")
        bmap("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        bmap("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage selection")
        bmap("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset selection")
        bmap("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        bmap("n", "<leader>gd", gs.diffthis, "Diff against index")
      end,
    },
  },
}
