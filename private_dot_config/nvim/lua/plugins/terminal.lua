return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<C-`>]],
            direction = "horizontal",
            shade_terminals = true,
            start_in_insert = true,
            persist_size = true,
            shell = "fish",
        })

        -- Multiple terminal shortcuts
        vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "[T]erminal [F]loat" })
        vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "[T]erminal [V]ertical" })
        vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>",
            { desc = "[T]erminal [H]orizontal" })
    end,
}
