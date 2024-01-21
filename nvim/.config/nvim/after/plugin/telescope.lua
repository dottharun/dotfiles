require("telescope").setup {
    pickers = {
        find_files = { hidden = true },
        git_files = { hidden = true },
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

vim.keymap.set("n", "<leader>ff", builtin.find_files, options)
-- for searching relative to current buffer
vim.keymap.set("n", "<leader>fc", function()
    builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
end, options)

vim.keymap.set("n", "<leader>fg", builtin.live_grep, options)
vim.keymap.set("n", "<C-p>", builtin.git_files, options)

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
