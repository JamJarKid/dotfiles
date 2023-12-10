local lualine = require('lualine')

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename', 'diagnostics' },
        lualine_x = { 'filetype' },
        lualine_y = { 'location' },
        lualine_z = { 'lsp_progress' }
    },
    inactive_sections = {
        -- configurations for inactive windows
    },
}
