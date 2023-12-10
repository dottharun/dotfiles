vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

local options = { noremap = true }
vim.keymap.set("i", "jj", "<Esc>", options)
vim.keymap.set("i", "jk", "<Esc>", options)
vim.keymap.set("i", "kj", "<Esc>", options)
