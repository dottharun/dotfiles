require('gitsigns').setup({
    signcolumn = false,
})

vim.keymap.set('n', '<leader>gs', ":Gitsigns toggle_signs<CR>")
-- vim.keymap.set('n', '<leader>gbl', ":Gitsigns blame_line<CR>")

--fugitive
vim.keymap.set('n', '<leader>gb', ":Git blame<CR>")
