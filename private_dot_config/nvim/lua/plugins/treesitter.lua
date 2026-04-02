-- Highlight, edit, and navigate code
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        ['af'] = { query = '@function.outer', desc = 'Around a function' },
                        ['if'] = { query = '@function.inner', desc = 'Inner part of a function' },
                        ['ac'] = { query = '@class.outer', desc = 'Around a class' },
                        ['ic'] = { query = '@class.inner', desc = 'Inner part of a class' },
                        ['ai'] = { query = '@conditional.outer', desc = 'Around a condition (if/else)' },
                        ['ii'] = { query = '@conditional.inner', desc = 'Inner part of a condition' },
                        ['al'] = { query = '@loop.outer', desc = 'Around a loop' },
                        ['il'] = { query = '@loop.inner', desc = 'Inner part of a loop' },
                    },
                },
            },
        }

        -- Ensure basic parsers are installed
        local parsers = {
            'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown',
            'markdown_inline', 'query', 'vim', 'vimdoc',
            'python', 'go', 'dart', 'dockerfile', 'yaml', 'toml'
        }
        require('nvim-treesitter').install(parsers)

        ---@param buf integer
        ---@param language string
        local function treesitter_try_attach(buf, language)
            if not vim.treesitter.language.add(language) then return end
            vim.treesitter.start(buf, language)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        local available_parsers = require('nvim-treesitter').get_available()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf, filetype = args.buf, args.match

                local language = vim.treesitter.language.get_lang(filetype)
                if not language then return end

                local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

                if vim.tbl_contains(installed_parsers, language) then
                    treesitter_try_attach(buf, language)
                elseif vim.tbl_contains(available_parsers, language) then
                    require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
                else
                    treesitter_try_attach(buf, language)
                end
            end,
        })
    end,
}
