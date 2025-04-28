local cmp = require("cmp")

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<Tab>'] = function(fallback)
      fallback()
    end,
  }),

  sources = {
    { name = 'nvim_lsp' }
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    fields = { "abbr", "kind", "menu"},
    format = function(entry, vim_item)
      return vim_item
    end,
  },

  experimental = {
    ghost_text = false,
  },
})

vim.opt.pumheight = 10
