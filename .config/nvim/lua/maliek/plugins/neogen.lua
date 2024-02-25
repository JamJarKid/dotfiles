return {
    'danymat/neogen',
    config = function()
        require('neogen').setup({
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convetion = "reST"
                    }
                },
            }
        })
    end,
    requires = "nvim-treesitter/nvim-treesitter",
}
