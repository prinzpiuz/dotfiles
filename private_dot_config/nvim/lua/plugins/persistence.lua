return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	config = function()
		require("persistence").setup()
	end,
}
