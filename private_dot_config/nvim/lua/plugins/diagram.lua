return {
	"3rd/diagram.nvim",
	dependencies = {
		{
			"3rd/image.nvim",
			build = false, -- skip the luarocks build
			opts = {
				backend = "kitty",
				processor = "magick_cli",
				integrations = {
					markdown = { enabled = false },
				},
			},
		},
	},
	config = function()
		local markdown = require("diagram.integrations.markdown")

		-- Same parser as markdown, but for the CodeCompanion chat buffer
		local codecompanion = vim.tbl_extend("force", markdown, {
			id = "codecompanion",
			filetypes = { "codecompanion" },
		})

		require("diagram").setup({
			integrations = { markdown, codecompanion },
			-- No automatic rendering: the chat buffer changes while the agent streams
			events = {
				render_buffer = {},
				clear_buffer = { "BufLeave" },
			},
			renderer_options = {
				mermaid = {
					theme = "neutral",
					background = "white",
				},
			},
		})

		vim.keymap.set("n", "<leader>mv", function()
			require("diagram").show_diagram_hover()
		end, { desc = "View diagram under cursor" })
	end,
}
