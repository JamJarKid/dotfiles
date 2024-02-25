return {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        -- Snippets
        'L3MON4D3/LuaSnip',
    },
    config = function()
        local lsp_zero = require('lsp-zero')
        local lspconfig = require('lspconfig')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        lsp_zero.preset("recommended")
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'pyright',
                'lua_ls',
                'tsserver',
                'clangd',
                'html',
                'cssls',
            },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            },
        })

        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        end)

        lsp_zero.setup()

        lspconfig.pyright.setup({
            settings = {
                pyright = { autoImportCompletion = true, disableTaggedHints = false },
                python = {
                    analysis = {
                        autoSearchPahts = true,
                        diagnosticMode = 'openfilesOnly',
                        useLibraryCodeforTypes = true,
                        typeCheckingMode = 'strict',
                    }
                }
            }
        })
        lspconfig.tsserver.setup({})
        lspconfig.mojo.setup({})
        lspconfig.clangd.setup({
            cmd = { '/opt/homebrew/opt/llvm/bin/clangd', '--clang-tidy' }
        })

        lspconfig.html.setup({
            capabilities = lsp_zero.capabilities,
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
            capabilities = lsp_zero.capabilities,
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
    end
}
