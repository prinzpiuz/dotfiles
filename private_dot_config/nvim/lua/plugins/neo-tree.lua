return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				position = "right",
				width = 40,
				mappings = {
					["<C-h>"] = "none",
					["<C-l>"] = "none",
					["<C-j>"] = "none",
					["<C-k>"] = "none",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				bind_to_cwd = false,
			},
		})
		vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file tree" })
	end,
}
