require('lint').linters_by_ft = {
    python = { 'flake8' },
    javascript = { 'eslint' },
    typescript = { 'eslint' },
    javascriptreact = { 'eslint' },
    typescriptreact = { 'eslint' },
}

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.py',
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)

        vim.fn.jobstart({ "black", filename }, {
            on_exit = function(exit_code)
                if exit_code ~= 0 then
                    print("Black formatting failed")
                else
                    vim.api.nvim_buf_call(bufnr, function()
                        vim.cmd("edit")
                    end)
                end
            end,
        })
    end
})
