local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp.preset("recommended")

lsp.ensure_installed({
  'pyright',
  'lua_ls',
  'tsserver',
  'clangd'
})

lsp.setup()

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.mojo.setup({})
lspconfig.clangd.setup({
    cmd = {'/opt/homebrew/opt/llvm/bin/clangd', '--clang-tidy' }
})

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
