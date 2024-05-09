require('gitsigns').setup({
    signcolumn = false,
})

vim.keymap.set('n', '<leader>gs', ":Gitsigns toggle_signs<CR>")
-- vim.keymap.set('n', '<leader>gbl', ":Gitsigns blame_line<CR>")

--fugitive
vim.keymap.set('n', '<leader>gb', ":Git blame<CR>")


--
-- git worktree
--
vim.keymap.set('n', '<leader>gww', "<cmd>Telescope git_worktree<CR>")

require('telescope').load_extension('git_worktree')
