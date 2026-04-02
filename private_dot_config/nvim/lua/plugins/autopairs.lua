return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local autopairs = require('nvim-autopairs')
        autopairs.setup({
            check_ts = true,        -- Enable treesitter integration
            ts_config = {
                lua = { 'string' }, -- Don't add pairs in lua string treesitter nodes
                javascript = { 'template_string' },
            },
        })
    end,
}
