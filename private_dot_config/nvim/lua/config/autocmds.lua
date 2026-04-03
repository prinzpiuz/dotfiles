-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        require("conform").format()
    end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})


vim.filetype.add({
    filename = {
        ['docker-compose.yml'] = 'yaml.docker-compose',
        ['docker-compose.yaml'] = 'yaml.docker-compose',
        ['compose.yml'] = 'yaml.docker-compose',
        ['compose.yaml'] = 'yaml.docker-compose',
    },
})
