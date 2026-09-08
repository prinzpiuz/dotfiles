-- Show pending keybinds
-- Show pending keybinds
return {
	"folke/which-key.nvim",
	event = "VimEnter",
	---@module 'which-key'
	---@type wk.Opts
	---@diagnostic disable-next-line: missing-fields
	opts = {
		delay = 0,
		icons = { mappings = vim.g.have_nerd_font },
		spec = {
			-- Search group (Telescope)
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },

			-- Toggle group
			{ "<leader>t", group = "[T]oggle / [T]erminal" },

			-- Git Hunk group (Gitsigns)
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },

			-- LSP actions
			{ "gr", group = "LSP Actions", mode = { "n" } },

			-- Debug group (DAP)
			{ "<leader>d", group = "[D]ebug" },

			-- AI group (CodeCompanion)
			{ "<leader>a", group = "[A]I", mode = { "n", "v" } },

			-- Flutter group
			{ "<leader>F", group = "[F]lutter" },

			-- Database group (DBee)
			{ "<leader>D", group = "[D]atabase" },

			-- Yank path group
			{ "<leader>y", group = "[Y]ank path" },

			-- Git group (Diffview)
			{ "<leader>g", group = "[G]it" },

			-- Trouble/diagnostics group
			{ "<leader>x", group = "Trouble / Diagnostics" },

			-- Code group (format, diagnostics copy)
			{ "<leader>c", group = "[C]ode" },

			-- Markdown group
			{ "<leader>m", group = "[M]arkdown" },

			-- Remote group (remote-sshfs)
			{ "<leader>r", group = "[R]emote" },
		},
	},
}
