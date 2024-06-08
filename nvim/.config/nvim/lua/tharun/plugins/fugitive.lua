return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")

		vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { desc = "[g]it [a]dd ." })
		vim.keymap.set("n", "<leader>gcs", ":Git commit -s<CR>", { desc = "[g]it [c]ommit --[s]igned" })

		vim.keymap.set(
			"n",
			"<leader>gdd",
			":Git diff --ws-error-highlight=all<CR>",
			{ desc = "[g]it [d]iff for only curr buff" }
		)
		vim.keymap.set(
			"n",
			"<leader>gdt",
			":Git difftool<CR>",
			{ desc = "[g]it [d]iff [t]ool for project as qf-hunks" }
		)
	end,
}
