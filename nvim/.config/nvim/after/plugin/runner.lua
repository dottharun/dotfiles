require('code_runner').setup({
    filetype = {
        -- java = {
        --     "cd $dir &&",
        --     "javac $fileName &&",
        --     "java $fileNameWithoutExt"
        -- },
        -- python = "python3 -u",
        -- typescript = "deno run",
        -- rust = {
        --     "cd $dir &&",
        --     "rustc $fileName &&",
        --     "$dir/$fileNameWithoutExt"
        -- },

        go = {
            "cd $dir &&",
            "go run ."
        }
    },
})

vim.keymap.set('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rk', ':RunClose<CR>', { noremap = true, silent = false }) -- can use ZZ anyway
-- vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
