-- Collection of various small independent plugins/modules
return {
    'nvim-mini/mini.nvim',
    config = function()
        -- Better Around/Inside textobjects
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        --  - sd'   - [S]urround [D]elete [']quotes
        --  - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        -- Simple and easy statusline.
        local statusline = require('mini.statusline')
        statusline.setup({
        use_icons = vim.g.have_nerd_font,
        content = {
            active = function()
                local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                local git = statusline.section_git({ trunc_width = 40 })
                local diff = statusline.section_diff({ trunc_width = 75 })
                local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
                local lsp = statusline.section_lsp({ trunc_width = 75 })
                local filename = statusline.section_filename({ trunc_width = 140 })
                local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
                local location = statusline.section_location({ trunc_width = 75 })
                local search = statusline.section_searchcount({ trunc_width = 75 })

                return statusline.combine_groups({
                    { hl = mode_hl,                 strings = { mode } },
                    { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                    '%<',
                    { hl = 'MiniStatuslineFilename', strings = { filename } },
                    '%=',
                    { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                    { hl = mode_hl,                  strings = { search, location } },
                })
            end,
        },
})
    end,
}
