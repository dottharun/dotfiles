local builtin = require("telescope.builtin")

local options = { noremap = true }

vim.keymap.set("n", "<leader>ff", builtin.find_files, options)
vim.keymap.set("n", "<C-p>", builtin.git_files, options)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, options)
