---@diagnostic disable: undefined-global
-- Main LSP Configuration
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Mason must be loaded before its dependents so we need to set it up here.
        -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
        {
            'mason-org/mason.nvim',
            ---@module 'mason.settings'
            ---@type MasonSettings
            ---@diagnostic disable-next-line: missing-fields
            opts = {},
        },
        -- Maps LSP server names between nvim-lspconfig and Mason package names.
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Rename the variable under your cursor.
                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action.
                map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                -- Goto Declaration (not Definition).
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                require("typescript-tools").setup({
                    on_attach = on_attach,
                    settings = {
                        -- spawn_tsserver_max_memory = 4096, -- Useful for large TS projects
                        expose_as_code_action = "all", -- Shows fix-its in the 'gra' menu
                    },
                })

                -- Highlight references of the word under cursor.
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight',
                        { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                -- Toggle inlay hints keymap
                if client and client:supports_method('textDocument/inlayHint', event.buf) then
                    map('<leader>th',
                        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
                        '[T]oggle Inlay [H]ints')
                end
            end,
        })

        ---@type table<string, vim.lsp.Config>
        local servers = {
            clangd = {},
            gopls = {},
            pyright = {},
            rust_analyzer = {},
            dockerls = {},
            taplo = {},
            bashls = {},
            docker_compose_language_service = {},
            yamlls = {
                settings = {
                    yaml = {
                        schemas = {
                            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                            "docker-compose*.{yml,yaml}",
                        },
                    },
                },
            },
            ruff = {
                on_attach = function(client)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end,
            },
            stylua = {}, -- Used to format Lua code

            -- Special Lua Config, as recommended by neovim help docs
            lua_ls = {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = { 'lua/?.lua', 'lua/?/init.lua' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                                '${3rd}/luv/library',
                                '${3rd}/busted/library',
                            }),
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            },
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'shfmt' -- Formatter for shell scripts (bash, zsh, etc.)
        })

        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        for name, server in pairs(servers) do
            vim.lsp.config(name, server)
            vim.lsp.enable(name)
        end
    end,
}
