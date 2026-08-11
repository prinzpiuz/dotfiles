-- TS-JS LSP
return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	config = function()
		local util = require("lspconfig.util")
		require("typescript-tools").setup({
			root_dir = util.root_pattern("tsconfig.json", "package.json", "jsconfig.json"),
			single_file_support = false,
		})
	end,
}
