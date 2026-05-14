return {
	"nosduco/remote-sshfs.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("remote-sshfs").setup({})
		require("telescope").load_extension("remote-sshfs")

		vim.keymap.set("n", "<leader>rc", "<cmd>RemoteSSHFSConnect<CR>", { desc = "Remote connect" })
		vim.keymap.set("n", "<leader>rd", "<cmd>RemoteSSHFSDisconnect<CR>", { desc = "Remote disconnect" })
		vim.keymap.set("n", "<leader>re", "<cmd>RemoteSSHFSEdit<CR>", { desc = "Remote edit host" })
	end,
}
