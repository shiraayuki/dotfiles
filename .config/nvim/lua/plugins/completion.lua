-- blink.cmp: schnelle Autocompletion (lädt vorkompilierten Fuzzy-Matcher, kein Rust nötig)
return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "enter", -- Enter übernimmt, Tab/S-Tab navigiert
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        -- Signaturhilfe manuell ein-/ausblenden (zeigt Parameter der Funktion)
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      appearance = { nerd_font_variant = "normal" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
        menu = { border = "rounded" },
      },
      signature = { enabled = true, window = { border = "rounded" } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
