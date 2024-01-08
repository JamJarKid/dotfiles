require("maliek.core.options")
require("maliek.core.keymaps")
require("maliek.core.colorscheme")
require("maliek.plugins.harpoon")
require("maliek.plugins.lsp")
require("maliek.plugins.lint")
require("maliek.plugins.telescope")
require("maliek.plugins.treesitter")
require("maliek.plugins.lualine")
require("maliek.plugins.nvim-cmp")
require("maliek.plugins.neogen")

local cppfuncs = require("maliek.core.cppfunctions")
vim.api.nvim_create_user_command('CppCompilef', cppfuncs.CompileFile, {})
vim.api.nvim_create_user_command('CppCompile', cppfuncs.Compile, {})
