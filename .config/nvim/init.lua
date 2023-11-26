require("maliek")
local lspconfig = require('lspconfig')

lspconfig.pyright.setup({})
lspconfig.clangd.setup({})
lspconfig.tsserver.setup({})
lspconfig.mojo.setup({})

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

require('lint').linters_by_ft = {
    python = {'flake8'},
    cpp = {'cpplint'},
    javascript = {'eslint'},
    typescript = {'eslint'},
    javascriptreact = {'eslint'},
    typescriptreact = {'eslint'},
}

vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter"}, {
    pattern = {'*.py', '*.cpp', '*.js', '*.ts', '*.jsx', '*.tsx'},
    callback = function()
        require('lint').try_lint()
    end
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.py',
    callback = function()
        vim.cmd('!black %')
    end
})

