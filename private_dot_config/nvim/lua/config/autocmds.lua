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

-- Auto-save when leaving insert mode or after text changes
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    callback = function(args)
        if vim.bo[args.buf].buftype == "" and vim.bo[args.buf].modified then
            vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].modified then
                    vim.api.nvim_buf_call(args.buf, function()
                        vim.cmd("silent! write")
                    end)
                end
            end, 1000)
        end
    end,
})

vim.filetype.add({
    filename = {
        ['docker-compose.yml'] = 'yaml.docker-compose',
        ['docker-compose.yaml'] = 'yaml.docker-compose',
        ['compose.yml'] = 'yaml.docker-compose',
        ['compose.yaml'] = 'yaml.docker-compose',
    },
})
