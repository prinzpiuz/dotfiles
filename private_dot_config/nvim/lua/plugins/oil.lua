-- File navigation
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional: for file icons
    config = function()
        require('oil').setup({
            columns = { "icon" },   -- Shows icons if you have a Nerd Font
            view_options = {
                show_hidden = true, -- Very useful for .env and .gitignore files
            },
        })
        -- Open oil with '-' (a common and very fast convention)
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
