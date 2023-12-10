require('lint').linters_by_ft = {
    python = { 'flake8' },
    javascript = { 'eslint' },
    typescript = { 'eslint' },
    javascriptreact = { 'eslint' },
    typescriptreact = { 'eslint' },
}

local group = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*.lua",
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 1000 })
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*.html",
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 1000 })
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = { "*.css", "*.scss", "*.less" },
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 1000 })
    end
})


vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 1000 })
    end
})

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

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.json", "*.md" },
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)

        vim.fn.jobstart({ "prettier", "--write", filename }, {
            on_exit = function(job_id, exit_code, event_type)
                if exit_code ~= 0 then
                    print("Prettier formatting failed")
                else
                    vim.api.nvim_buf_call(bufnr, function()
                        vim.cmd("edit")
                    end)
                end
            end,
        })
    end
})
