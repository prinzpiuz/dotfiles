return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	build = function()
		require("dbee").install()
	end,
	config = function()
		require("dbee").setup({
			sources = {
				require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
				require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
			},
		})

		vim.keymap.set("n", "<leader>Do", function()
			require("dbee").open()
		end, { desc = "DBee Open" })
		vim.keymap.set("n", "<leader>Dc", function()
			require("dbee").close()
		end, { desc = "DBee Close" })
		vim.keymap.set("n", "<leader>Dt", function()
			require("dbee").toggle()
		end, { desc = "DBee Toggle" })
	end,
}
