-- File navigation
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('oil').setup({
            columns = { "icon" },
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["<C-v>"] = { "actions.select", opts = { vertical = true } },
                ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-r>"] = "actions.refresh",
            },
            skip_confirm_for_simple_edits = true,
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
