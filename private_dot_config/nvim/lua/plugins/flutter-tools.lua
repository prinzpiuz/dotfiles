return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
	config = function()
		require("flutter-tools").setup({
			debugger = {
				enabled = true,
				run_via_dap = true,
				exception_breakpoints = {},
			},
			widget_guides = {
				enabled = true,
			},
			closing_tags = {
				enabled = true,
				prefix = "// ",
			},
			lsp = {
				color = {
					enabled = true,
					virtual_text = true,
				},
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					renameFilesWithClasses = "prompt",
					enableSnippets = true,
				},
			},
			dev_log = {
				enabled = true,
				open_cmd = "tabedit",
			},
		})

		-- Flutter keymaps
		vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { desc = "Flutter Run" })
		vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
		vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Restart" })
		vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterReload<CR>", { desc = "Flutter Reload" })
		vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })
		vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
		vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter Outline" })
		vim.keymap.set("n", "<leader>Fg", "<cmd>FlutterDevLog<CR>", { desc = "Flutter Dev Log" })
		vim.keymap.set("n", "<leader>Fa", "<cmd>FlutterLspRestart<CR>", { desc = "Flutter LSP Restart" })
	end,
}
