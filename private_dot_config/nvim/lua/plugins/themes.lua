return {
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = true,
        priority = 1000,
        config = function()
            -- Moonfly options (set before colorscheme loads)
            vim.g.moonflyItalics = true
            vim.g.moonflyNormalFloat = true
            vim.g.moonflyWinSeparator = 2        -- Thicker window separators
            vim.g.moonflyVirtualTextColor = true -- Colored virtual text for diagnostics

            -- vim.cmd.colorscheme("moonfly")
        end,
    },
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                colors = {},
                highlights = {},
                styles = {
                    types = "NONE",
                    methods = "NONE",
                    numbers = "NONE",
                    strings = "NONE",
                    comments = "italic",
                    keywords = "bold",
                    constants = "NONE",
                    functions = "italic",
                    operators = "NONE",
                    variables = "NONE",
                    parameters = "NONE",
                    conditionals = "italic",
                    virtual_text = "NONE",
                },
                options = {
                    bold = true,
                    italic = true,
                    underline = true,
                    undercurl = true,
                    cursorline = true,
                    transparency = false,
                    terminal_colors = true,
                    highlight_inactive_windows = false,
                },
            })
            vim.cmd.colorscheme("onedark_dark")
        end,
    },
}
