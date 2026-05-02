return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'mason-org/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        -- Language specific helpers
        'leoluz/nvim-dap-go',
        'mfussenegger/nvim-dap-python',
    },
    keys = {
        { '<F5>',      function() require('dap').continue() end,                                            desc = 'Debug: Start/Continue' },
        { '<F1>',      function() require('dap').step_into() end,                                           desc = 'Debug: Step Into' },
        { '<F2>',      function() require('dap').step_over() end,                                           desc = 'Debug: Step Over' },
        { '<F3>',      function() require('dap').step_out() end,                                            desc = 'Debug: Step Out' },
        { '<leader>b', function() require('dap').toggle_breakpoint() end,                                   desc = 'Debug: Toggle Breakpoint' },
        { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
        { '<F7>',      function() require('dapui').toggle() end,                                            desc = 'Debug: See last session result.' },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {
                'delve',   -- Go
                'debugpy', -- Python
                'chrome',  -- Web (JS/TS/React) via Chrome
                'firefox', -- Web (JS/TS/React) via Firefox
            },
        }

        dapui.setup {
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸', play = '▶', step_into = '⏎', step_over = '⏭',
                    step_out = '⏮', step_back = 'b', run_last = '▶▶', terminate = '⏹', disconnect = '⏏',
                },
            },
        }

        -- Auto open/close UI
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        --------------------------
        -- Language Configurations
        --------------------------

        -- 1. Go
        require('dap-go').setup()

        -- 2. Python (Optimized for uv)
        local function get_python_path()
            -- Check if we are in a uv/venv environment
            local venv_path = os.getenv('VIRTUAL_ENV')
            if venv_path then
                return venv_path .. '/bin/python'
            end

            -- Fallback to local .venv folder created by uv
            local local_venv = vim.fn.getcwd() .. '/.venv/bin/python'
            if vim.fn.executable(local_venv) == 1 then
                return local_venv
            end

            -- Final fallback to system python
            return 'python3'
        end

        require('dap-python').setup(get_python_path())
        -- uv run uvicorn app.main:create_app --factory --reload --port 8000
        table.insert(dap.configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'FastAPI',
            module = 'uvicorn',
            args = { 'app.main:create_app','--factory', '--reload', '--port', '8000' },
            jinja = true,
            cwd = '${workspaceFolder}',
            pythonPath = get_python_path,
        })

        -- 3. Dart / Flutter
        -- Note: Dart usually requires the Flutter tools to be set up.
        -- If you use 'akinsho/flutter-tools.nvim', it handles DAP automatically.
        dap.configurations.dart = {
            {
                type = 'dart',
                request = 'launch',
                name = 'Launch Flutter',
                dartSdkPath = 'dart',       -- Update this if dart is not in path
                flutterSdkPath = 'flutter', -- Update this if flutter is not in path
                program = '${workspaceFolder}/lib/main.dart',
                cwd = '${workspaceFolder}',
            }
        }

        -- 4. TypeScript / JavaScript / React
        dap.configurations.typescript = {
            {
                type = 'chrome',
                request = 'attach',
                name = 'Attach to Chrome',
                cwd = '${workspaceFolder}',
                sourceMaps = true,
                protocol = 'inspector',
                port = 9222,
                webRoot = '${workspaceFolder}',
            },
            {
                type = 'chrome',
                request = 'launch',
                name = 'Launch Chrome',
                url = 'http://localhost:3000',
                webRoot = '${workspaceFolder}',
                userDataDir = false,
            },
            {
                type = 'firefox',
                request = 'attach',
                name = 'Attach to Firefox',
                cwd = '${workspaceFolder}',
                sourceMaps = true,
                port = 6000,
                webRoot = '${workspaceFolder}',
            },
            {
                type = 'firefox',
                request = 'launch',
                name = 'Launch Firefox',
                url = 'http://localhost:3000',
                webRoot = '${workspaceFolder}',
                firefoxExecutable = 'firefox',
            },
        }
        dap.configurations.javascript = dap.configurations.typescript
        dap.configurations.typescriptreact = dap.configurations.typescript
        dap.configurations.javascriptreact = dap.configurations.typescript
    end,
}
