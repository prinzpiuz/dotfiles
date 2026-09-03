return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = { adapter = "codex" },
				inline = { adapter = "codex" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions" })
		vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "AI Chat" })
		vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "AI Inline" })
	end,
}
