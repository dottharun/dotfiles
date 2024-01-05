require("oil").setup({
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },

    -- DEFAULT KEYMAPS JUST KEEPING HERE FOR REFERENCE

    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        -- ["<C-h>"] = "actions.select_split",
        ["<C-h>"] = false,
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = false,
        ["<C-c>"] = "actions.close",
        -- ["<C-l>"] = "actions.refresh",
        ["<C-l>"] = false,
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory", })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory", })
