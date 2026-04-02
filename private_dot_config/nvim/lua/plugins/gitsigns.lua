-- Git signs and hunk actions
return {
    'lewis6991/gitsigns.nvim',
    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
            local gitsigns = require 'gitsigns'
            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation: Jump between changes
            map('n', ']c', function()
                if vim.wo.diff then vim.cmd.normal { ']c', bang = true } else gitsigns.nav_hunk 'next' end
            end, { desc = 'Jump to next git [c]hange' })

            map('n', '[c', function()
                if vim.wo.diff then vim.cmd.normal { '[c', bang = true } else gitsigns.nav_hunk 'prev' end
            end, { desc = 'Jump to previous git [c]hange' })

            -- Actions: Stage, Reset, Preview
            map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
            map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
            map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
            map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line' })
            map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })

            -- Toggles: The "GitLens" features
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
            map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git [w]ord diff' })
        end,
    },
}
