return {
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,
        config = function()
            -- Moonfly options (set before colorscheme loads)
            vim.g.moonflyItalics = true
            vim.g.moonflyNormalFloat = true
            vim.g.moonflyWinSeparator = 2        -- Thicker window separators
            vim.g.moonflyVirtualTextColor = true -- Colored virtual text for diagnostics

            vim.cmd.colorscheme("moonfly")
        end,
    },
}
