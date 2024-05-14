require('duckytype').setup{
    number_of_words = 30,
}

vim.keymap.set("n", "<leader>mt", ":DuckyType<CR>", { desc = "[m]ake [t]ype" })
