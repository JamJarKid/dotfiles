return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'super-tab' = Tab to select next item, Enter to accept. 
        keymap = { preset = 'super-tab' },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono', 
        },

        -- Default sources (LSP, snippets, current buffer words)
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        
        -- Enable the signature help (floating window with function args)
        signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
}