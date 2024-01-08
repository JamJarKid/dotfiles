return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'theprimeagen/harpoon'
    use 'christoomey/vim-tmux-navigator'
    use 'mfussenegger/nvim-lint'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'bluz71/vim-nightfly-colors',
        as = 'nightfly'
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use {
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

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
end)
