local lsp = require('lsp-zero')

lsp.preset("recommended")
lsp.ensure_installed({
  'pyright',
  'lua_ls',
  'tsserver',
  'clangd'
})

lsp.setup()
