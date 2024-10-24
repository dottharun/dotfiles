return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            pickers = {
                find_files = { hidden = true },
                git_files = { show_untracked = true },
                live_grep = {
                    glob_pattern = "!package-lock.json",
                    additional_args = function(_)
                        return { "--hidden" }
                    end,
                },
            },
            defaults = {
                file_ignore_patterns = { ".git/", "node_modules/", "__generated__/", "ccls%-cache" },
            },
        })

        local builtin = require("telescope.builtin")
        local options = { noremap = true }

        -- think folder means project thus folder find, folder grep
        vim.keymap.set("n", "<leader>ff", builtin.find_files, options)
        vim.keymap.set("n", "<leader>fl", builtin.live_grep, options)

        -- find grep and search
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, options)
        vim.keymap.set("n", "<leader>fs", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        -- find telescope
        vim.keymap.set("n", "<leader>ft", builtin.builtin, options)

        vim.keymap.set("n", "<C-p>", builtin.git_files, options)
        vim.keymap.set("n", "<leader>fbb", builtin.buffers, {})
    end,
}
