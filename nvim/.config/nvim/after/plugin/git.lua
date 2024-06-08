require('gitsigns').setup({
    signcolumn = false,
})

vim.keymap.set('n', '<leader>gs', ":Gitsigns toggle_signs<CR>")
vim.keymap.set('n', '<leader>gp', ":Gitsigns preview_hunk_inline<CR>")
vim.keymap.set('n', '<leader>gr', ":Gitsigns reset_hunk<CR>")

--fugitive
vim.keymap.set('n', '<leader>gb', ":Git blame<CR>")

vim.keymap.set('n', '<leader>ga', ":Git add .<CR>", { desc = "[g]it [a]dd ." })
vim.keymap.set('n', '<leader>gcs', ":Git commit -s<CR>", { desc = "[g]it [c]ommit --[s]igned" })

vim.keymap.set('n', '<leader>gdd', ":Git diff --ws-error-highlight=all<CR>", { desc = "[g]it [d]iff for only curr buff" })
vim.keymap.set('n', '<leader>gdt', ":Git difftool<CR>", { desc = "[g]it [d]iff [t]ool for project as qf-hunks" })

--
-- git worktree --- TODO: needs to be removed
--
vim.keymap.set('n', '<leader>gww', "<cmd>Telescope git_worktree<CR>")

require('telescope').load_extension('git_worktree')
