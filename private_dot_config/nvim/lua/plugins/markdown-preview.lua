return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_open_to_the_world = 0
		vim.g.mkdp_browser = ""

		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview" })
	end,
}
