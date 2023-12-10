require("maliek")
local lspconfig = require('lspconfig')

lspconfig.pyright.setup({})
lspconfig.clangd.setup({
    cmd = {'/opt/homebrew/opt/llvm/bin/clangd', '--clang-tidy' }
})
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
    javascript = {'eslint'},
    typescript = {'eslint'},
    javascriptreact = {'eslint'},
    typescriptreact = {'eslint'},
}

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.py',
    callback = function()
        vim.cmd('!black %')
    end
})

function CompileCpp()
    local dir = vim.fn.expand('%:p:h')
    local output = vim.fn.expand('%:t:r')
    local cmd = string.format("g++-13 -std=c++23 -fdiagnostics-color=always -g -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion -Werror %s/*.cpp -o %s/%s", dir, dir, output)
    vim.api.nvim_command('! '..cmd)
end

vim.api.nvim_create_user_command('CppCompile', CompileCpp, {})

function CompileCppFile()
    local file = vim.fn.expand('%')
    local dir = vim.fn.expand('%:p:h')
    local output = vim.fn.expand('%:t:r')
    local cmd = string.format("g++-13 -std=c++23 -g -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion -Werror %s -o %s/%s", file, dir, output)
    vim.api.nvim_command('! '..cmd)
end

vim.api.nvim_create_user_command('CppCompilef', CompileCppFile, {})

