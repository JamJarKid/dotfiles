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

