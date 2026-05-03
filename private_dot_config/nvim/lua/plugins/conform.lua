-- Formatting
return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>f',
            function() require('conform').format { async = true, lsp_format = 'fallback' } end,
            mode = '',
            desc = '[F]ormat buffer',
        },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages without well standardized coding style.
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then
                return nil
            else
                return {
                    timeout_ms = 500,
                    lsp_format = 'fallback',
                }
            end
        end,
formatters = {
    stylua = {
        command = vim.fn.expand("~/.cargo/bin/stylua"),
    },
},
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { "ruff_organize_imports", "ruff_format" },
            typescript = { 'prettierd', 'prettier', stop_after_first = true },
            typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            go = { 'goimports', 'gofmt' },
            sh = { 'shfmt' },
            dart = { 'dart_format' },
            yaml = { 'prettierd', 'prettier', stop_after_first = true },
            json = { 'prettierd', 'prettier', stop_after_first = true },
            ["docker-compose"] = { 'prettierd', 'prettier', stop_after_first = true },
        },
    },
}
