return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			adapters = {
				acp = {
					codex = function()
						return require("codecompanion.adapters").extend("codex", {
							defaults = {
								auth_method = "chatgpt",
							},
						})
					end,
					claude_code = function()
						return require("codecompanion.adapters").extend("claude_code", {
							env = {
								ANTHROPIC_API_KEY = "ANTHROPIC_API_KEY",
							},
						})
					end,
				},
			},
			strategies = {
				chat = { adapter = "claude_code" },
				inline = { adapter = "claude_code" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions" })
		vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "AI Chat" })
		vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "AI Inline" })

		-- Quick adapter switches — open chat with a specific model
		vim.keymap.set("n", "<leader>aC", "<cmd>CodeCompanionChat claude_code<CR>", { desc = "AI Chat (Claude Code)" })
		vim.keymap.set("n", "<leader>aX", "<cmd>CodeCompanionChat codex<CR>", { desc = "AI Chat (Codex)" })
	end,
}
