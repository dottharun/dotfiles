require('gitsigns').setup({
    signcolumn = false,
})

vim.keymap.set('n', '<leader>gss', ":Gitsigns toggle_signs<CR>")
vim.keymap.set('n', '<leader>gsl', ":Gitsigns preview_hunk_inline<CR>")

--fugitive
vim.keymap.set('n', '<leader>gb', ":Git blame<CR>")

vim.keymap.set('n', '<leader>gdd', ":Git diff<CR>", { desc = "[g]it [d]iff for only curr buff" })
vim.keymap.set('n', '<leader>gdt', ":Git difftool<CR>", { desc = "[g]it [d]iff [t]ool for project as qf-hunks" })


--
-- git worktree
--
vim.keymap.set('n', '<leader>gww', "<cmd>Telescope git_worktree<CR>")

require('telescope').load_extension('git_worktree')
