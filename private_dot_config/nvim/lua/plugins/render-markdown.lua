return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	ft = { "markdown", "codecompanion" },
	opts = {
		file_types = { "markdown", "codecompanion" },
		render_modes = { "n", "c", "t" },
		pipe_table = {
			preset = "round",
		},
		code = {
			sign = false,
			width = "block",
		},
	},
}
