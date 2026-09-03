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
								auth_method = "chat-gpt",
							},
						})
					end,
				},
			},
			strategies = {
				chat = { adapter = "codex" },
				inline = { adapter = "codex" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions" })
		vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "AI Chat" })
		vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "AI Inline" })
		vim.keymap.set("n", "<leader>ap", "<cmd>CodeCompanionActions<CR>", { desc = "AI Prompt Library" })
	end,
}
