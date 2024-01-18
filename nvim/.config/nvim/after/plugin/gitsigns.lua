require('gitsigns').setup({
    signcolumn = false,
})

vim.keymap.set('n', '<leader>gs', ":Gitsigns toggle_signs<CR><ESC>")
vim.keymap.set('n', '<leader>gb', ":Gitsigns blame_line<CR><ESC>")
