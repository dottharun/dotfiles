require "trouble".setup({
    icons = false,
    fold_open = "~",      -- icon used for open folds
    fold_closed = "|",    -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "[ERR]",
        warning = "[WARN]",
        hint = "[HINT]",
        information = "[INFO]"
    },
    use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client

    padding = false,
    cycle_results = false,
})

vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end)

-- can make it to goto references
vim.keymap.set("n", "gr", function() require("trouble").toggle("lsp_references") end)
vim.keymap.set("n", "<leader>tr", function() require("trouble").toggle("lsp_references") end)

