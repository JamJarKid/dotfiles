return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'saghen/blink.cmp',
    },
    config = function()
        -- 1. THE CAPABILITIES (The glue between LSP and Blink)
        -- We get these from Blink and pass them to every server
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        -- 2. THE KEYMAPS (Modern LspAttach way)
        -- This runs every time an LSP connects to a buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end

                if client.server_capabilities.semanticTokensProvider then
                    vim.lsp.semantic_tokens.start(args.buf, client.id)
                end

                local opts = { buffer = args.buf, remap = false }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            end,
        })

        -- 3. SETUP MASON & HANDLERS
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'basedpyright',
                'lua_ls',
                'ts_ls',
                'clangd',
                'html',
                'cssls',
                'emmet_language_server',
                'jsonls',
                'yamlls',
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                basedpyright = function()
                    require('lspconfig').basedpyright.setup({
                        capabilities = capabilities,
                        settings = {
                            pyright = {
                                autoImportCompletion = true,
                                disableTaggedHints = false
                            },
                            python = {
                                analysis = {
                                    autoSearchPaths = true,
                                    diagnosticMode = 'openFilesOnly',
                                    useLibraryCodeForTypes = true,
                                    typeCheckingMode = 'strict',
                                }
                            }
                        }
                    })
                end,

                clangd = function()
                    require('lspconfig').clangd.setup({
                        capabilities = capabilities,
                        cmd = { '/opt/homebrew/opt/llvm/bin/clangd', '--clang-tidy' }
                    })
                end,

                html = function()
                    require('lspconfig').html.setup({
                        capabilities = capabilities,
                        settings = {
                            html = {
                                format = { enable = true },
                                validate = { scripts = true, styles = true },
                            },
                        },
                    })
                end,

                cssls = function()
                    require('lspconfig').cssls.setup({
                        capabilities = capabilities,
                        settings = {
                            css = {
                                validate = true,
                                lint = {
                                    ['block-no-empty'] = true,
                                    ['color-no-invalid-hex'] = true,
                                    ['declaration-block-trailing-semicolon'] = "always",
                                    ['no-duplicate-selectors'] = true,
                                },
                                format = { enable = false },
                            },
                        },
                    })
                end,

                lua_ls = function()
                    local runtime_path = vim.split(package.path, ';')
                    table.insert(runtime_path, "lua/?.lua")
                    table.insert(runtime_path, "lua/?/init.lua")

                    require('lspconfig').lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = 'LuaJIT', path = runtime_path },
                                diagnostics = { globals = { 'vim' } },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    maxPreload = 10000,
                                    preloadFileSize = 1000,
                                    checkThirdParty = false,
                                },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
            },
        })
    end
}
