local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.preset("recommended")
lsp.ensure_installed({
    'pyright',
    'lua_ls',
    'tsserver',
    'clangd',
    'html',
    'cssls',
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end)

lsp.setup()

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.mojo.setup({})
lspconfig.clangd.setup({
    cmd = { '/opt/homebrew/opt/llvm/bin/clangd', '--clang-tidy' }
})

lspconfig.html.setup({
    capabilities = lsp.capabilities,
    settings = {
        html = {
            format = {
                enable = true,
            },
            validate = {
                scripts = true,
                styles = true,
            },
        },
    },
})

lspconfig.cssls.setup({
    capabilities = lsp.capabilities,
    settings = {
        css = {
            validate = true,
            lint = {
                ['block-no-empty'] = true,
                ['color-no-invalid-hex'] = true,
                ['declaration-block-trailing-semicolon'] = "always",
                ['no-duplicate-selectors'] = true,
            },
            format = {
                enable = false,
                indentSize = 4,
                insertSpaces = true,
            },
        },
    },
})


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                maxPreload = 10000,
                preloadFileSize = 1000,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
