return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- Optional: for better UI
    },
    config = function()
        require("flutter-tools").setup {}
    end,
}
