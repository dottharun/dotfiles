return {
	"tpope/vim-fugitive",
	config = function()
		-- status line with fugitive git branch name
		vim.cmd([[
        " status line
        set statusline=%<\ %{mode()}\ \|\ %{FugitiveStatusline()}\ \|\ %f%m
        set statusline+=%{&paste?'\ \ \|\ PASTE\ ':'\ '}
        set statusline+=%=\ %l/%L\(%c\)\ \|\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}
        set statusline+=%{'\ '}

        " syntax highlighting
        syntax sync minlines=256
        ]])

		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[g]it [s]tatus" })
		vim.keymap.set("n", "<leader>gb", ":Git blame %<CR>", { desc = "[g]it [b]lame" })
		vim.keymap.set("n", "<leader>gll", ":Git log<CR>", { desc = "[g]it [l]og" })
		vim.keymap.set("n", "<leader>glo", ":Git log --oneline<CR>", { desc = "[g]it [l]og --[o]neline" })

		vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { desc = "[g]it [a]dd ." })
		vim.keymap.set("n", "<leader>gcs", ":Git commit -s<CR>", { desc = "[g]it [c]ommit --[s]igned" })

		vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { desc = "[g]it [d]iff for only curr buff" })
		vim.keymap.set("n", "<leader>gt", ":Git difftool<CR>", { desc = "[g]it diff [t]ool for project as qf-hunks" })
	end,
}
