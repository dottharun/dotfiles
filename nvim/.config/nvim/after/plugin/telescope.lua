local builtin = require("telescope.builtin")

local options = { noremap = true }

vim.keymap.set("n", "<leader>pf", builtin.find_files, options)
vim.keymap.set("n", "<leader>pg", builtin.live_grep, options)
vim.keymap.set("n", "<C-p>", builtin.git_files, options)

vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
