require("telescope").setup {
    pickers = {
        find_files = { hidden = true },
        git_files = { show_untracked = true },
        live_grep = {
            additional_args = function(_) return { "--hidden" } end
        },
    },
    defaults = {
        file_ignore_patterns = { ".git/", "node_modules/" }
    }
}

local builtin = require("telescope.builtin")

local options = { noremap = true }

-- think folder means project thus folder find, folder grep
vim.keymap.set("n", "<leader>ff", builtin.find_files, options)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, options)

vim.keymap.set("n", "<leader>ft", builtin.builtin, options)

-- for searching relative to current buffer dir
vim.keymap.set("n", "<leader>fbf", function() builtin.find_files({ cwd = vim.fn.expand("%:p:h") }) end, options)
vim.keymap.set("n", "<leader>fbg", function() builtin.live_grep({ cwd = vim.fn.expand("%:p:h") }) end, options)

vim.keymap.set("n", "<C-p>", builtin.git_files, options)
vim.keymap.set('n', '<leader>fbb', builtin.buffers, {})

-- seems to make fzf native work
require('telescope').load_extension('fzf')
