return {
	"pmizio/typescript-tools.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local util = require("lspconfig.util")
		require("typescript-tools").setup({
			root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
			settings = {
				expose_as_code_action = "all",
			},
		})
	end,
}
