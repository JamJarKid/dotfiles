return {'mfussenegger/nvim-lint',
config = function()
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
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 1000 })
    end
})

vim.api.nvim_create_autocmd("bufWritePost", {
    pattern = "*.py",
    command = "silent !black %",
    group = group,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.json", "*.md" },
    command = "silent !prettier --write %",
})
end
}


 
