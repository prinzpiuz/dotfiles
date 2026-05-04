-- File navigation
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					local hidden = {
						"__pycache__",
						".git",
						"node_modules",
						".mypy_cache",
						".pytest_cache",
						".ruff_cache",
						"__pypackages__",
						".venv",
						"*.pyc",
						".DS_Store",
					}
					-- Exact match
					for _, pattern in ipairs(hidden) do
						if name == pattern then
							return true
						end
					end
					-- Extension match (for patterns like *.pyc)
					if name:match("%.pyc$") then
						return true
					end
					return false
				end,
			},
			keymaps = {
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-x>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-r>"] = "actions.refresh",
			},
			skip_confirm_for_simple_edits = true,
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
