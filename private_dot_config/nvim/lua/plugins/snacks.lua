return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		notifier = { enabled = true },
		-- disable everything that overlaps with your existing plugins
		picker = { enabled = false },
		explorer = { enabled = false },
		indent = { enabled = false },
		input = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		dashboard = { enabled = false },
		words = { enabled = false },
	},
}
