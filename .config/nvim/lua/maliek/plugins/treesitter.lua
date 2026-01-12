return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Add this line
    config = function()
        -- Remove the ts_update line, the 'build' key above handles it
        require('nvim-treesitter').setup {
            ensure_installed = { "vimdoc", "javascript", "typescript", "python", "c", "lua", "cpp", "html", "css", "json", "markdown" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
